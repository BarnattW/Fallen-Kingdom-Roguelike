class_name MaxHealth extends Node2D

@export var health_multiplayer = 0.1
var ability_level : int = 1
var owning_entity: CharacterBody2D

func start(entity : CharacterBody2D) -> void:
	if entity.has_method("change_health"):
		owning_entity = entity
		change_max_health(owning_entity.max_health)

func change_max_health(original_health: float ) -> void:
	owning_entity.change_max_health(original_health * (1 + health_multiplayer*ability_level))

func upgrade() -> void:
	var original_health = owning_entity.max_health / (1 + health_multiplayer*ability_level)
	ability_level += 1
	change_max_health(original_health)
	print(owning_entity.max_health)
