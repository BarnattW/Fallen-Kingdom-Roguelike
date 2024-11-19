extends Node2D

@export var max_trees : int = 50
var trees : Array[Node2D] = []

func spawn_trees() -> void:
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
		var player_pos : Vector2 = $Player.global_position
		if new_tree.global_position.distance_to(player_pos) > 200:
			add_child(new_tree)
			trees.append(new_tree)
		
		add_child(new_rock)
		trees.append(new_rock)
	remove_far_trees()

func remove_far_trees() -> void:
	var player_position : Vector2 = $Player.global_position
	for i in range(trees.size() - 1, -1, -1):
		var tree : Node2D = trees[i];
		if tree and tree.global_position.distance_to(player_position) > 1500:
			tree.queue_free()
			trees.remove_at(i)

func _on_timer_timeout() -> void:
	spawn_trees();

func _on_player_health_depleted() -> void:
	%GameOver.visible = true;
	get_tree().paused = true;

func _on_button_button_down() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
