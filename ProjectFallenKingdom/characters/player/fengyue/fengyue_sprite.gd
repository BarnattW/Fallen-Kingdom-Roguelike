extends Node2D

var ACCEL = 0;

func play_idle_animation():
	ACCEL = 0;
	$AnimatedSprite2D.play("idle");

func play_accel_animation():
	#$AnimatedSprite2D.play("accel");
	pass

func play_running_animation():
	pass
	
	#if ACCEL == 0:
		#play_accel_animation();
		#ACCEL = 1;
	$AnimatedSprite2D.play("running");
