class_name Fengyue extends Player

# abilities
var move = load_ability("move")
var sword_attack = load_ability("sword_slash")
var dash = load_ability("dash");
var crescent_strike = load_ability("crescent_strike")
var magic_circle = load_ability("magic_circle")
var last_horizontal_dir = 1

# dash states
var is_dashing: bool = false

func _ready() -> void:
	magic_circle.exec(self)

func _read_input():
	if Input.is_action_just_pressed("dash") and !is_dashing:
		dash.exec(self);
	elif !is_dashing:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		move.exec(self, direction)
		if direction.x != 0:
			last_horizontal_dir = 1 if direction.x > 0 else -1
	
	if Input.is_action_just_pressed("ability_1"):
		crescent_strike.exec(self);

func _physics_process(delta: float) -> void:
	_read_input()
	
	if velocity.length() > 0.0:
		pass
		%fengyue_sprite.play_running_animation();
	else:
		%fengyue_sprite.play_idle_animation();
	
	%fengyue_sprite/AnimatedSprite2D.flip_h = last_horizontal_dir < 0
	
	# take damage and emit signals when health changes and falls below 0
	const DAMAGE_RATE = 5.0;
	var overlapping_mobs = %HurtBox.get_overlapping_bodies();
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		health_changed.emit(health)
		if health <= 0.0:
			health_depleted.emit()

# calls attack ability on timeout
func _on_attack_timer_timeout() -> void:
	sword_attack.exec(self)
