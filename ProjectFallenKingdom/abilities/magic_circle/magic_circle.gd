class_name MagicCircle extends Attack

var attack : MagicCircleAttack

func _ready():
	attack_path = preload("res://ProjectFallenKingdom/abilities/magic_circle/magic_circle_attack.tscn")
	
func start(player) -> void:
	owning_entity = player
	attack = spawn_attack(attack_path, position, 0)
	add_child(attack)

func upgrade() -> void:
	super()
	attack.upgrade(attack_level)
