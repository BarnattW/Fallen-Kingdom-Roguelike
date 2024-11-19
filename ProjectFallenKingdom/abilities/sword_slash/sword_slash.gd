class_name SwordSlash extends Attack

@onready var slash_cooldown_timer : Timer = %SwordSlashTimer
@export var slash_cooldown : float = 1.5

func _ready() -> void:
	attack_cooldown = slash_cooldown
	spawn_distance = 150
	attack_path = preload("res://ProjectFallenKingdom/abilities/sword_slash/sword_wave.tscn")
	
	slash_cooldown_timer.one_shot = false
	slash_cooldown_timer.wait_time = attack_cooldown

func start(player : CharacterBody2D) -> void:
	owning_entity = player
	slash_cooldown_timer.start()

func exec(player : CharacterBody2D) -> void:
	#find_enemies()
	attack_name = "sword_wave"
	var cursor_position : Vector2 = get_viewport().get_mouse_position()
	var world_cursor_position : Vector2 = player.get_global_mouse_position()
	var direction : Vector2 = (world_cursor_position - player.global_position).normalized()
	var new_attack : Projectile = spawn_attack(attack_path, direction * spawn_distance, direction.angle())
	add_child(new_attack);
	
	AudioStreamManager.play("res://ProjectFallenKingdom/abilities/sword_slash/sword-sound-2-36274.mp3")

func _on_sword_slash_timer_timeout() -> void:
	exec(owning_entity)

func upgrade() -> void:
	super()
	match attack_level:
		2:
			update_cooldown(1.2, slash_cooldown_timer)
		3:
			update_cooldown(0.8, slash_cooldown_timer)
		4:
			update_cooldown(0.5, slash_cooldown_timer)
		5:
			update_cooldown(0.3, slash_cooldown_timer)
