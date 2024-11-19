extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
	
	if body.has_method("gain_exp"):
		body.gain_exp(randi_range(1, 10))


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		AudioStreamManager.play("res://ProjectFallenKingdom/sfx/coin.mp3")
		queue_free()
	
	if area.get_parent().has_method("gain_exp"):
		area.get_parent().gain_exp(randi_range(1, 10))
