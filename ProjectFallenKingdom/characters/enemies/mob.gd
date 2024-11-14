class_name Mob extends CharacterBody2D

signal add_score_on_death;

# Basic attributes
@export var health : int = 3;
@export var speed : float = 100.0;
@onready var player : CharacterBody2D = get_node("/root/Base Level/Player");
@onready var coin = preload("res://ProjectFallenKingdom/level_up/coin.tscn");

func _ready():
	$Wisp.play_idle_animation();

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position);
	velocity = direction * speed;
	move_and_slide();

func take_damage(damage : float):
	health -= damage;
	$Wisp.play_hurt_animation();
	
	if health <= 0:
		const SMOKE_SCENE = preload("res://HappyBoo/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate();
		get_parent().add_child(smoke);
		smoke.global_position = global_position; # change global position to mob's global position
		
		var new_coin = coin.instantiate()
		get_parent().add_child(new_coin)
		new_coin.global_position = global_position
		
		add_score_on_death.emit(1);
		queue_free();
