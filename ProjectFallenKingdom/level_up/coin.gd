extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
	
	if body.has_method("gain_exp"):
		body.gain_exp(randi_range(1, 10))
