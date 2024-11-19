class_name Attack extends Area2D

var attack_name : String
var attack_path : Resource
var attack_level : int = 1
var attack_cooldown : float
var owning_entity : CharacterBody2D
@export var spawn_distance : float = 150

# logic for targeting. Child will control visuals and collisions
func find_enemies() -> Vector2 :
	var enemies_in_range : Array[Node2D] = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy : Node2D = get_closest_enemy(enemies_in_range)
		return target_enemy.global_position
	return Vector2.ZERO

func get_closest_enemy(enemies : Array[Node2D]) -> Node2D:
	var closest_distance : float = INF
	var closest_enemy : Node2D = null
	for enemy in enemies:
		var distance : float = get_parent().global_position.distance_squared_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy

func spawn_attack(attack_path : Resource, pos : Vector2, rot : float) -> Projectile:
	var new_attack : Projectile = attack_path.instantiate()
	new_attack.level = attack_level

	new_attack.global_position = pos
	new_attack.global_rotation = rot
	return new_attack

func upgrade() -> void:
	attack_level += 1

func update_cooldown(new_cooldown : float, timer : Timer) -> void:
	attack_cooldown = new_cooldown
	timer.wait_time = new_cooldown

func exec(player : CharacterBody2D) -> void:
	# implement in child
	pass
