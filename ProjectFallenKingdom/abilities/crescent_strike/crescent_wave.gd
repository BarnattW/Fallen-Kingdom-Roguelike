class_name CrescentWave extends Projectile

func _ready():
	DAMAGE = 1
	RANGE = 800
	match level:
		1: 
			pass
		2:
			pass
		3:
			RANGE = 1000
			SPEED = 1200

func _on_body_entered(body: Node2D) -> void:
	#queue_free();
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE);
