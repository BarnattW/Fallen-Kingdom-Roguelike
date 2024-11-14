class_name SwordWave extends Projectile

func _ready():
	# melee attack
	SPEED = 0
	RANGE = 0
	DAMAGE = 1  # Overriding the DAMAGE value from the parent class
	$AnimatedSprite2D.slash_finished.connect(_on_slash_finished.bind())
	$AnimatedSprite2D.play("slash")

func _on_body_entered(body: Node2D) -> void:
	#queue_free();
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE);

func _on_slash_finished():
	queue_free()
