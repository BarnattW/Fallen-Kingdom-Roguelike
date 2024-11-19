class_name Move extends Node2D

func exec(player : Player, direction) -> void :
	player.velocity = direction * player.speed
	player.move_and_slide()
