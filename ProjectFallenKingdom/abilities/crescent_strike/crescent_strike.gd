class_name CrescentStrike extends Attack

@export var crescent_cooldown : float= 1.5
@onready var crescent_cooldown_timer : Timer = %CresentCooldownTimer

signal cooldown_started

func _ready():
	attack_path = preload("res://ProjectFallenKingdom/abilities/crescent_strike/crescent_wave.tscn")
	
	# set up timers and connect signals that are called when timer ends
	crescent_cooldown_timer.one_shot = false
	crescent_cooldown_timer.wait_time = crescent_cooldown

func start(player : CharacterBody2D) -> void:
	owning_entity = player
	exec(owning_entity)	
	crescent_cooldown_timer.start()

func exec(player : CharacterBody2D) -> void:
	var closest_enemy_position : Vector2 = find_enemies()
	if (closest_enemy_position == null):
		return
	var direction : Vector2 = (closest_enemy_position - player.global_position).normalized()

	var new_attack : Projectile = spawn_attack(attack_path, direction * spawn_distance, direction.angle())
	add_child(new_attack);
	
	if attack_level >= 3:
		var additional_attack : Timer = Timer.new()
		add_child(additional_attack)
		additional_attack.wait_time = 0.1
		var spawn_attack : Projectile = spawn_attack(attack_path, direction * spawn_distance, direction.angle())
		additional_attack.timeout.connect(add_attack.bind(spawn_attack))
		additional_attack.start()
	
	AudioStreamManager.play("res://ProjectFallenKingdom/sfx/crescent.mp3")
	
	# start timer and emit signal
	cooldown_started.emit(crescent_cooldown_timer);

func _on_cresent_cooldown_timer_timeout() -> void:
	exec(owning_entity)

func add_attack(new_attack : Projectile) -> void:
	if is_instance_valid(new_attack):
		add_child(new_attack)
	else:
		pass

func upgrade() -> void:
	super()
	match attack_level:
		2:
			update_cooldown(1.2, crescent_cooldown_timer)
		3:
			update_cooldown(0.9, crescent_cooldown_timer)
		4:
			update_cooldown(0.6, crescent_cooldown_timer)
		5:
			update_cooldown(0.4, crescent_cooldown_timer)
