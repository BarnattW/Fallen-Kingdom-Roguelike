extends Node2D

func play_idle_animation():
	$AnimatedSprite2D.play("idle")

func play_hurt_animation():
	$AnimatedSprite2D.play("hurt")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "hurt":
		$AnimatedSprite2D.play("idle")
