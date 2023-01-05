extends StaticBody2D

var oreAmount
var isSelected

var astorid1 = preload("res://GameObjects/Resources/Asteroid/astorid1.png")
var astorid2 = preload("res://GameObjects/Resources/Asteroid/astorid2.png")
var astorid3 = preload("res://GameObjects/Resources/Asteroid/astorid3.png")
var astorid4 = preload("res://GameObjects/Resources/Asteroid/astorid4.png")

onready var ui = get_node("UI")
onready var uiButton = get_node("UI/Button")
onready var sprite = get_node("Spin/Astoroid")

onready var Inventory = get_node("Inventory")

# Called when the node enters the scene tree for the first time.
func _ready():
	ui.visible = false
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	oreAmount = rng.randi_range(0, 1000)
	Inventory.addToInventory("ore", oreAmount)
	var spriteList = [astorid1, astorid2, astorid3, astorid4]
	var name = spriteList[randi() % spriteList.size()]
	sprite.set_texture(name)
	Inventory.visible = false

func getInventory():
	return Inventory
	
func select():
	isSelected = true
	ui.visible = true
	Inventory.visible = true

func deselect():
	isSelected = false
	ui.visible = false
	Inventory.visible = false

func _on_Button_pressed():
	UnitManager.createMinJob(self, "player")
