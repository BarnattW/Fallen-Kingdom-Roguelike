class_name EnemySpawner extends Node2D

@onready var player_ui : CanvasLayer = %PlayerUi
@onready var timer : Timer = $Timer
@export var spawn_types : Array[SpawnInfo] = []

var time : int = 0

func _ready() -> void:
	timer.one_shot = false
	timer.start()

func _on_timer_timeout() -> void:
	time += 1
	var enemy_spawns : Array[SpawnInfo] = spawn_types
	for enemy in enemy_spawns:
		if time > enemy.time_start and time < enemy.time_end:
			if enemy.spawn_delay_counter < enemy.enemy_spawn_delay:
				enemy.spawn_delay_counter += 1
			else:
				enemy.spawn_delay_counter = 0;
				var new_enemy : Resource = load(str(enemy.enemy.resource_path))
				var counter : int = 0
				while counter < enemy.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					enemy_spawn.add_score_on_death.connect(player_ui._add_score.bind());
					counter += 1

func get_random_position() -> Vector2:
	%PathFollow2D.progress_ratio = randf();
	return %PathFollow2D.global_position
