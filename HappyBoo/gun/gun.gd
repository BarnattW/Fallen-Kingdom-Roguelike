extends Area2D

@export var attack_speed = 0.4;

func _physics_process(delta: float) -> void:
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

func attack():
	const ATTACK_VIS = preload("res://ProjectFallenKingdom/abilities/sword_slash/sword_slash.tscn");
	var new_slash = ATTACK_VIS.instantiate();
	new_slash.global_position = %ProjectileSpawn.global_position;
	new_slash.global_rotation = %ProjectileSpawn.global_rotation;
	%ProjectileSpawn.add_child(new_slash);


func _on_timer_timeout() -> void:
	attack();
