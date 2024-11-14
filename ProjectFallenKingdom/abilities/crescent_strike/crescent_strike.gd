class_name CrescentStrike extends Attack

@export var crescent_cooldown = 0.5

@onready var crescent_cooldown_timer: Timer = %CresentCooldownTimer

signal cooldown_started

func _ready():
	attack_path = preload("res://ProjectFallenKingdom/abilities/crescent_strike/crescent_wave.tscn")
	
	# set up timers and connect signals that are called when timer ends
	crescent_cooldown_timer.one_shot = true
	crescent_cooldown_timer.wait_time = crescent_cooldown
	crescent_cooldown_timer.timeout.connect(self._end_cooldown.bind())
	
func _end_cooldown() -> void:
	pass

func exec(player) -> void:
	if crescent_cooldown_timer.is_stopped() == false:
		return
		
	#find_enemies()
	var cursor_position = get_viewport().get_mouse_position()
	var world_cursor_position = player.get_global_mouse_position()
	var direction = (world_cursor_position - player.global_position).normalized()
	var new_attack = spawn_attack(attack_path, direction * spawn_distance, direction.angle())
	add_child(new_attack);
	
	# start timer and emit signal
	crescent_cooldown_timer.start()
	cooldown_started.emit(crescent_cooldown_timer);
