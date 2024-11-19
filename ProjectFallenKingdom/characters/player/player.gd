class_name Player extends CharacterBody2D

# Signals
signal health_depleted
signal health_changed
signal max_health_changed
signal exp_changed
signal leveled_up

# Basic attributes
@export var health : float = 100.0
@export var max_health : float = 100.0
@export var speed : float = 600.0
@export var attack_speed : float = 0.4;
var pickup_radius : float = 80
var pickup_area : CollisionShape2D

# ability system
# tags are still unused, and probably unneccessary for this project
var tag : Dictionary = {}

# leveling & upgrade system
@onready var upgrade_component : Resource = preload("res://ProjectFallenKingdom/level_up/upgrade_component.tscn")
var player_upgrade_component : UpgradeComponent
var level : int = 1
var exp : int = 0
var required_exp : int = get_required_exp(level)

func _ready() -> void:
	player_upgrade_component = upgrade_component.instantiate()
	add_child(player_upgrade_component)

func load_ability(name : String):
	var ability = load("res://ProjectFallenKingdom/abilities/" + name + "/" + name + ".tscn")
	var abilityInstance = ability.instantiate()
	add_child(abilityInstance)
	return abilityInstance

func gain_exp(val : int) -> void:
	exp += val
	while exp >= required_exp:
		exp -= required_exp
		level_up()
	exp_changed.emit(exp, required_exp)
		
func level_up() -> void:
	level += 1
	required_exp = get_required_exp(level)
	
	# level signal emitted and trigger upgrade component
	leveled_up.emit(level)
	player_upgrade_component.show_upgrades()

func get_required_exp(level : int) -> int:
	# calculates based on level (a parabola curve)
	return round(pow(level, 2.4) + level * 6 + 10)
	
func change_health(value : float) -> void:
	if health == max_health:
		pass
		
	health += value
	if value < 0:
		AudioStreamManager.play("res://ProjectFallenKingdom/sfx/hitHurt.wav")
	if health > max_health:
		health = max_health
	health_changed.emit(health)
	if health <= 0.0:
		health_depleted.emit()

func change_max_health(new_max : float) -> void:
	var health_change = new_max - max_health
	max_health = new_max
	
	max_health_changed.emit(new_max)
	change_health(health_change)
	
func change_pickup_radius(new_radius : float)-> void:
	pickup_radius = new_radius
	if pickup_area:
		pickup_area.shape.radius = new_radius
