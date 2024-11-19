class_name UpgradeComponent extends Node2D
## The UpgradeComponent is attached to a player node and manages all upgrades from leveling
##
## All abilities and upgrades are subsequently stored inside and managed in this component
## although abilities are attached to the player
##

# UI
@onready var upgrade_ui : Control
@onready var item_options : Resource = preload("res://ProjectFallenKingdom/ui/upgrade_ui/item_option.tscn")
var panel : Panel

# Core
@onready var player : Player = get_parent()
var abilities : Dictionary = {} # maintains reference to applied abilities
var upgrades : Array[String] = [] # a future optimization is to maintain a dictionay copy of all upgrades, and remove them when picked
var upgrade_options : Array[String] = []

func _ready() -> void:
	upgrade_ui = player.get_node("CanvasLayer/UpgradeUI")
	panel = upgrade_ui.get_child(0)
	
	# adjust position
	#var screen_size = get_viewport_rect().size
	#var panel_size = panel.size
	#var center_position = (screen_size - panel_size) / 2
	#panel.position = center_position

## displays upgrade panel with populated options, and pauses the game
func show_upgrades() -> void:
	# create tween that moves to center of the screen
	var screen_size : Vector2 = get_viewport_rect().size
	var panel_size : Vector2 = panel.size
	var center_position : Vector2 = (screen_size - panel_size) / 2
	var tween : Tween = panel.create_tween()
	tween.tween_property(panel, "position", center_position, 0.2).set_trans(tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	panel.visible = true
	
	# add upgrade options
	var upgrade_ops : VBoxContainer = panel.get_child(0)
	
	for i in range(3):
		var option_choice : ItemOption = item_options.instantiate()
		option_choice.upgrade_component = self
		option_choice.item = get_random_item()
		upgrade_ops.add_child(option_choice)
	
	get_tree().paused = true

## applies upgrade selection
func upgrade_character(upgrade : String):
	# clean up ui
	var panel : Panel = upgrade_ui.get_child(0)
	var options : Array[Node] = panel.get_child(0).get_children()
	for option in options:
		option.queue_free()
	upgrade_options.clear()
	panel.visible = false
	get_tree().paused = false
	
	# apply upgrade
	upgrades.append(upgrade)
	if upgrade == "food":
		player.change_health(player.max_health * 0.2)
		return
		
	var ability_name : String = upgrade.substr(0, upgrade.length() - 1)
	if ability_name not in abilities:
		var ability = player.load_ability(ability_name)
		abilities[ability_name] = ability
		ability.start(player)
		return ability
	else:
		abilities[ability_name].upgrade()
		return abilities[ability_name]

## returns an upgrade in the list of upgrades that meets criteria
func get_random_item():
	var dbList : Array[String] = []
	
	# filters out selected upgrades and upgrades whose prequisites have not been matched
	for upgrade in UpgradeDb.UPGRADES:
		if upgrade in upgrades:
			pass
		elif upgrade in upgrade_options:
			pass
		elif UpgradeDb.UPGRADES[upgrade]["prerequisites"].size() > 0:
			for prereq in UpgradeDb.UPGRADES[upgrade]["prerequisites"]:
				if not prereq in upgrades:
					pass
				else:
					dbList.append(upgrade)
		else:
			dbList.append(upgrade)
		
	# from list of candidates, return a random one
	if dbList.size() > 0:
		var randomItem : String = dbList.pick_random()
		upgrade_options.append(randomItem)
		return randomItem
	else:
		return
