class_name MagicCircle extends Attack

func _ready():
	attack_path = preload("res://ProjectFallenKingdom/abilities/magic_circle/magic_circle_attack.tscn")
	
func exec(player) -> void:
	var cursor_position = get_viewport().get_mouse_position()
	var world_cursor_position = player.get_global_mouse_position()
	var direction = (world_cursor_position - player.global_position).normalized()
	var new_attack = spawn_attack(attack_path, position, 0)
	add_child(new_attack);
