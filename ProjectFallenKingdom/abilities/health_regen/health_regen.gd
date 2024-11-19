class_name HealthRegen extends Node2D

@onready var heal_timer : Timer = $HealTimer
var ability_level : int = 1
var owning_entity : CharacterBody2D
var heal_cooldown : float = 5

func _ready() -> void:
	heal_timer.one_shot = false
	heal_timer.autostart = false
	heal_timer.wait_time = heal_cooldown

func start(entity : CharacterBody2D) -> void:
	if entity.has_method("change_health"):
		owning_entity = entity
		apply_heal(entity)
		heal_timer.timeout.connect(self._end_cooldown.bind(entity))
		heal_timer.start()

func upgrade() -> void:
	ability_level += 1
	
func _end_cooldown(entity : CharacterBody2D) -> void:
	apply_heal(entity)

func apply_heal(entity : CharacterBody2D):
	entity.change_health(entity.max_health * ability_level * 0.01)
