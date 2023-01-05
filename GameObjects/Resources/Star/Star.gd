extends StaticBody2D


var star1 = preload("res://GameObjects/Resources/Star/star_blue01.png")
var star2 = preload("res://GameObjects/Resources/Star/star_orange01.png")
var star3 = preload("res://GameObjects/Resources/Star/star_red01.png")
var star4 = preload("res://GameObjects/Resources/Star/star_red_giant01.png")
var star5 = preload("res://GameObjects/Resources/Star/star_white01.png")
var star6 = preload("res://GameObjects/Resources/Star/star_yellow02.png")

onready var sprite = get_node("Spin/Sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	#ui.visible = false
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#oreAmount = rng.randi_range(0, 1000)
	#Inventory.addToInventory("ore", oreAmount)
	var spriteList = [star1, star2, star3, star4, star5, star6]
	var name = spriteList[randi() % spriteList.size()]
	sprite.set_texture(name)
	#Inventory.visible = false


func select():
	pass

func deselect():
	pass
