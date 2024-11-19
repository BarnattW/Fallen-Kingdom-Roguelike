class_name PickupRadius extends Node2D

@export var range_multiplayer = 0.4
var ability_level : int = 1
var owning_entity: CharacterBody2D

func start(entity : CharacterBody2D) -> void:
	owning_entity = entity
	change_pickup_radius(owning_entity.pickup_radius)

func change_pickup_radius(original_radius: float ) -> void:
	owning_entity.change_pickup_radius(original_radius * (1 + range_multiplayer*ability_level))

func upgrade() -> void:
	var original_radius = owning_entity.pickup_radius / (1 + range_multiplayer*ability_level)
	ability_level += 1
	change_pickup_radius(original_radius)
