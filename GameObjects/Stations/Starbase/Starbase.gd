extends StaticBody2D

var isSelected
var isRegistered = false

onready var Inventory = get_node("Inventory")

# Called when the node enters the scene tree for the first time.
func _ready():
	if isRegistered != true:
		print("Ready Station")
		Inventory.visible = false
		UnitManager.registerBase(self, "player")
		isRegistered = true
	#TEST CODE: Remove later
	Inventory.addToInventory("metal", 100)
	Inventory.updateInventoryOwner(self)
	#Inventory.enableTransportJobs()
	#addToInventory("parts", 100)

func getInventory():
	return Inventory

func select():
	isSelected = true
	Inventory.visible = true

func deselect():
	isSelected = false
	Inventory.visible = false
	
func doesProcess(item):
	if item == "ore":
		return true
	return false

func _on_OreProcessor_timeout():
	var canProcess = Inventory.removeFromInventory("ore", 1)
	if canProcess:
		Inventory.addToInventory("metal", 1)
