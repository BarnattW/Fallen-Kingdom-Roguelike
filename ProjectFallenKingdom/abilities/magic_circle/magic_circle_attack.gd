class_name MagicCircleAttack extends Projectile

@onready var damage_tick_timer : Timer = %DamageTickTimer

var bodies : Array = []
var tick_cooldown : float = 1.4

func _ready():
	SPEED = 0
	RANGE = 0
	DAMAGE = 1
	
	# set up timers and connect signals that are called when timer ends
	damage_tick_timer.autostart = true
	damage_tick_timer.one_shot = false
	damage_tick_timer.wait_time = tick_cooldown
	damage_tick_timer.timeout.connect(self._end_cooldown.bind())
	damage_tick_timer.start()
	$AnimationPlayer.play("idle")

func upgrade(new_level):
	level = new_level
	match level:
		2:
			self.scale *= 1.2
		3:
			self.scale *= 1.3
		4:
			tick_cooldown = 1
			damage_tick_timer.wait_time = tick_cooldown
		5:
			self.scale *= 1.3

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		bodies.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("take_damage"):
		bodies.erase(body)

func _end_cooldown():
	for body in bodies:
		body.take_damage(DAMAGE)
