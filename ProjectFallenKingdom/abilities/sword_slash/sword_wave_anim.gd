extends AnimatedSprite2D

signal slash_finished

func _ready() -> void:
	self.animation_finished.connect(_on_animation_finished)

func play_slash_animation() -> void:
	$AnimatedSprite2D.play("slash")

func _on_animation_finished() -> void:
	slash_finished.emit()
