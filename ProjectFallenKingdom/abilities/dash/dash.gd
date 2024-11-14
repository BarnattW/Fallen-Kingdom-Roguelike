class_name Dash extends Node2D

@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

@export var dash_speed: float = 1500 
@export var dash_duration: float = 0.4
@export var dash_cooldown: float = 2.0
var dash_direction: Vector2 = Vector2.ZERO

signal cooldown_started

func _ready():
	# set up timers and connect signals that are called when timer ends
	dash_duration_timer.one_shot = true;
	dash_duration_timer.wait_time = dash_duration
	dash_cooldown_timer.one_shot = true;
	dash_cooldown_timer.wait_time = dash_cooldown
	dash_duration_timer.timeout.connect(self._end_dash.bind())
	dash_cooldown_timer.timeout.connect(self._end_cooldown.bind())

func exec(player: Player) -> void:
	if get_parent().is_dashing or dash_cooldown_timer.is_stopped() == false:
		return
		
	# Start the dash
	var cursor_position = get_viewport().get_mouse_position()
	var world_cursor_position = player.get_global_mouse_position()
	dash_direction = (world_cursor_position - player.position).normalized()

	get_parent().is_dashing = true
	get_parent().velocity = dash_direction * dash_speed
	get_parent().last_horizontal_dir = 1 if dash_direction.x > 0 else -1
	
	# start dash duration timer
	dash_duration_timer.start()

	#player.$AnimatedSprite2D.play("dash")

func _end_dash() -> void:
	get_parent().is_dashing = false
	get_parent().velocity = Vector2.ZERO
	
	# Start cooldown timer after dash ends
	dash_cooldown_timer.start()
	cooldown_started.emit(dash_cooldown_timer)
	
func _end_cooldown() -> void:
	pass

func _process(delta: float) -> void:
	if get_parent().is_dashing:
		get_parent().move_and_slide()
