extends TextureProgressBar

var cooldown_timer: Timer

func _ready() -> void:
	var player : Player = get_tree().get_root().find_child("Player", true, false)
	var crescent : CrescentStrike = player.get_node("CrescentStrike")
	crescent.cooldown_started.connect(self._on_cooldown_start.bind())

func _on_cooldown_start(cd_timer : Timer) -> void:
	self.value = 100
	cooldown_timer = cd_timer

func _process(delta: float) -> void:
	if cooldown_timer and cooldown_timer.is_stopped() == false:
		self.value = ceil(int((cooldown_timer.time_left / cooldown_timer.wait_time) * 100))
