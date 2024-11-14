class_name MagicCircleAttack extends Projectile

var bodies : Array = []

func _ready():
	SPEED = 0
	RANGE = 0
	DAMAGE = 1

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("take_damage"):
		bodies.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("take_damage"):
		bodies.erase(body)

func _physics_process(delta: float) -> void:
	for body in bodies:
		body.take_damage(DAMAGE)
