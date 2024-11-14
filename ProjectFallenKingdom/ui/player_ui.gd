class_name PlayerUI extends CanvasLayer

var score : int = 0;
var time_elapsed: float = 0.0
var minutes: int = 0
var seconds: int = 0

func _ready() -> void:
	%Score.text = "Score: " + str(score); 
	
func _process(delta: float) -> void:
	time_elapsed += delta
	minutes = int(time_elapsed) / 60
	seconds = int(time_elapsed) % 60
	update_time_display()
	
func update_time_display():
	%TIme.text = "Time: %02d:%02d" % [minutes, seconds]

func _on_player_health_changed(health : float) -> void:
	%HealthBar.value = health;

func _add_score(point : int) -> void:
	score += point;
	%Score.text = "Score: " + str(score); 

func _on_player_exp_changed(exp : float, required_exp : float) -> void:
	%ExpProgressBar.value = exp / required_exp

func _on_player_leveled_up(level : int) -> void:
	%Level.text = str(level)
