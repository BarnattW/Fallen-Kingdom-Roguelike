extends CharacterBody2D

signal health_depleted;

@export var health : float = 100.0;
@export var speed : float = 600.0;

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = direction * speed;
	move_and_slide();
	
	if (direction.x < 0): 
		$Scarlet/AnimatedSprite2D.flip_h = true
	else:
		$Scarlet/AnimatedSprite2D.flip_h = false
	
	if velocity.length() > 0.0:
		%Scarlet.play_running_animation();
	else:
		%Scarlet.play_idle_animation();
	
	const DAMAGE_RATE = 5.0;
	var overlapping_mobs = %HurtBox.get_overlapping_bodies();
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health;
		if health <= 0.0:
			health_depleted.emit();
