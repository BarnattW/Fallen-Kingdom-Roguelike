class_name Attack extends Area2D

var attack_name
var attack_path
@export var SPEED : float = 1000
@export var RANGE : float = 1200
@export var spawn_distance = 150

# logic for targeting. Child will control visuals and collisions

func find_enemies():
	var enemies_in_range = get_overlapping_bodies();
	if enemies_in_range.size() > 0:
		var target_enemy = get_closest_enemy(enemies_in_range);
		look_at(target_enemy.global_position);

func get_closest_enemy(enemies : Array[Node2D]) -> Node2D:
	var closest_distance = INF;
	var closest_enemy = null;
	for enemy in enemies:
		var distance = get_parent().global_position.distance_squared_to(enemy.global_position);
		if distance < closest_distance:
			closest_distance = distance;
			closest_enemy = enemy;
	return closest_enemy;

func spawn_attack(attack_path, pos, rot):
	var new_attack = attack_path.instantiate();
	var cursor_position = get_viewport().get_mouse_position()

	new_attack.global_position = pos
	new_attack.global_rotation = rot
	return new_attack

func exec(player):
	# implement in child
	pass
