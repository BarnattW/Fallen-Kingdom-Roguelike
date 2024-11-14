class_name SwordSlash extends Attack

func _ready() -> void:
	SPEED = 1000
	RANGE = 1200
	spawn_distance = 150
	attack_path = preload("res://ProjectFallenKingdom/abilities/sword_slash/sword_wave.tscn")

func exec(player) -> void:
	#find_enemies()
	attack_name = "sword_wave"
	var cursor_position = get_viewport().get_mouse_position()
	var world_cursor_position = player.get_global_mouse_position()
	var direction = (world_cursor_position - player.global_position).normalized()
	var new_attack = spawn_attack(attack_path, direction * spawn_distance, direction.angle())
	add_child(new_attack);
	$SlashSound.play()
	
