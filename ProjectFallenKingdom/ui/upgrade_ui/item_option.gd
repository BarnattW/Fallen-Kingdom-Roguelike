class_name ItemOption extends Button

@onready var item_name = $ItemName
@onready var item_desc = $ItemDescription
@onready var item_type = $ItemType
@onready var item_icon = %ItemIcon

var upgrade_component : UpgradeComponent
var item : String = ""
var mouse_over : bool = false

signal selected_upgrade(upgrade)

func _ready():
	selected_upgrade.connect(Callable(upgrade_component, "upgrade_character"))
	
	if item == "":
		item = "food"
	
	item_name.text = UpgradeDb.UPGRADES[item]["display_name"] + " " + UpgradeDb.UPGRADES[item]["level"]
	item_desc.text = UpgradeDb.UPGRADES[item]["description"]
	item_type.text = UpgradeDb.UPGRADES[item]["type"]
	item_icon.texture = load(UpgradeDb.UPGRADES[item]["icon"])

func _on_button_down() -> void:
	print("selecting " + item)
	selected_upgrade.emit(item)
	AudioStreamManager.play("res://ProjectFallenKingdom/sfx/select.mp3")

func _on_mouse_entered() -> void:
	AudioStreamManager.play("res://ProjectFallenKingdom/sfx/click.mp3")
