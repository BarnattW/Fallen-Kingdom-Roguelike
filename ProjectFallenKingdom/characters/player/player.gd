class_name Player extends CharacterBody2D

signal health_depleted
signal health_changed
signal exp_changed
signal leveled_up

# Basic attributes
@export var health : float = 100.0
@export var speed : float = 600.0
@export var attack_speed : float = 0.4;

# tagging for ability system
var tag = {}

# leveling system
var level : int = 1
var exp : int = 0
var required_exp : int = get_required_exp(level)

func _physics_process(delta: float) -> void:
	pass	

func load_ability(name):
	var ability = load("res://ProjectFallenKingdom/abilities/" + name + "/" + name + ".tscn")
	var abilityInstance = ability.instantiate()
	add_child(abilityInstance)
	return abilityInstance

func gain_exp(val : int):
	exp += val
	while exp >= required_exp:
		exp -= required_exp
		level_up()
	exp_changed.emit(exp, required_exp)
		
func level_up():
	level += 1
	required_exp = get_required_exp(level)
	leveled_up.emit(level)

func get_required_exp(level):
	# calculates based on level (a parabola curve)
	return round(pow(level, 2.4) + level * 6 + 10)
