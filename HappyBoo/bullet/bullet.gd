extends Area2D

@export var SPEED : float = 1000
@export var RANGE : float = 1200
var travelled_distance : float = 0;

func _physics_process(delta: float) -> void: 
	var direction = Vector2.RIGHT.rotated(rotation); # get current bullet direction
	position += direction * SPEED * delta;
	
	travelled_distance += SPEED * delta;
	if travelled_distance > RANGE:
		queue_free();

func _on_body_entered(body: Node2D) -> void:
	queue_free();
	if body.has_method("take_damage"):
		body.take_damage();
