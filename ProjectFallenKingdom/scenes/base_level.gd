extends Node2D

@export var max_trees : int = 50
var trees = []

@onready var player_ui = $PlayerUi

func spawn_trees():
	var new_tree = preload("res://ProjectFallenKingdom/environment/pine_tree.tscn")
	var new_rock = preload("res://ProjectFallenKingdom/environment/rock.tscn")
	%PathFollow2D.progress_ratio = randf()
	if trees.size() < max_trees:
		new_tree = new_tree.instantiate();
		new_tree.global_position = %PathFollow2D.global_position
		
		%PathFollow2D.progress_ratio = randf()
		new_rock = new_rock.instantiate();
		new_rock.global_position =  %PathFollow2D.global_position
		
		# get player position and don't spawn tree if too close
		var player_pos = $Player.global_position
		if new_tree.global_position.distance_to(player_pos) > 200:
			add_child(new_tree)
			trees.append(new_tree)
		
		add_child(new_rock)
		trees.append(new_rock)
	remove_far_trees()

func remove_far_trees():
	var player_position = $Player.global_position
	for i in range(trees.size() - 1, -1, -1):
		var tree = trees[i];
		if tree and tree.global_position.distance_to(player_position) > 1500:
			tree.queue_free()
			trees.remove_at(i)

func spawn_mob():
	var new_mob = preload("res://ProjectFallenKingdom/characters/enemies/mob.tscn").instantiate();
	%PathFollow2D.progress_ratio = randf();
	new_mob.global_position = %PathFollow2D.global_position;
	add_child(new_mob);
	new_mob.add_score_on_death.connect(player_ui._add_score.bind());

func _on_timer_timeout() -> void:
	spawn_mob();
	spawn_trees();

func _on_player_health_depleted() -> void:
	%GameOver.visible = true;
	get_tree().paused = true;

func _on_button_button_down() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
