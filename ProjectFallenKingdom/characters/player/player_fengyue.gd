class_name Fengyue extends Player

# abilities
var move : Move = load_ability("move")
var sword_attack : SwordSlash
var dash : Dash = load_ability("dash");
var crescent_strike : CrescentStrike = load_ability("crescent_strike")
var last_horizontal_dir : int = 1

# dash states
var is_dashing: bool = false

# temporary for taking damage
var bodies : Array = []
var tick_cooldown : float = 1

func _ready() -> void:
	super()
	sword_attack = player_upgrade_component.upgrade_character("sword_slash1")
	pickup_area = %PickupRadius
	%PickupRadius.shape.radius = pickup_radius
	%DamageTimer.start()

func _read_input():
	if dash && Input.is_action_just_pressed("dash") and !is_dashing:
		dash.exec(self);
	elif !is_dashing:
		var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
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

func _on_hurt_box_body_entered(body: Node2D) -> void:
	bodies.append(body)
	change_health(-1)

func _on_hurt_box_body_exited(body: Node2D) -> void:
	bodies.erase(body)

func _on_damage_timer_timeout() -> void:
	for body in bodies:
		change_health(-1)
