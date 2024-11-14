class_name CrescentWave extends Projectile

func _ready():
	DAMAGE = 2  # Overriding the DAMAGE value from the parent class

func _on_body_entered(body: Node2D) -> void:
	#queue_free();
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE);
