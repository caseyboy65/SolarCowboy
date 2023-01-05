extends StaticBody2D


var planet1 = preload("res://GameObjects/Resources/Planet/planet1.png")
var planet2 = preload("res://GameObjects/Resources/Planet/planet2.png")
var planet3 = preload("res://GameObjects/Resources/Planet/planet3.png")
var planet4 = preload("res://GameObjects/Resources/Planet/planet4.png")
var planet5 = preload("res://GameObjects/Resources/Planet/planet5.png")
var planet6 = preload("res://GameObjects/Resources/Planet/planet6.png")

onready var sprite = get_node("Spin/Sprite")

#test
# Called when the node enters the scene tree for the first time.
func _ready():
	#ui.visible = false
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#oreAmount = rng.randi_range(0, 1000)
	#Inventory.addToInventory("ore", oreAmount)
	var spriteList = [planet1, planet2, planet3, planet4, planet5, planet6]
	var name = spriteList[randi() % spriteList.size()]
	sprite.set_texture(name)
	#Inventory.visible = false

func select():
	pass

func deselect():
	pass
