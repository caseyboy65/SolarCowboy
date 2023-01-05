extends StaticBody2D

var isSelected
var isConstructed = false
var currentConstructionMetalUsed = 0
var constructionMetalNeeded = 1
onready var ConstuctionSprite : Sprite = get_node("Spin/ConstructionSprite") 
onready var StationSprite : Sprite = get_node("Spin/StationSprite")
onready var constuctionTimer : Timer = get_node("ConstructionTimer")

onready var Inventory = get_node("Inventory")

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory.updateInventoryOwner(self)

func getInventory():
	return Inventory

func select():
	isSelected = true
	Inventory.visible = true

func deselect():
	isSelected = false
	Inventory.visible = false

func startConstruction():
	for x in constructionMetalNeeded:
		var jobData = {}
		jobData.resource = "metal"
		jobData.target = self
		jobData.type = UnitManager.JobTypes.SUPPLY
		UnitManager.createJob(jobData)
	StationSprite.visible = false
	ConstuctionSprite.visible = true
	
func completeConstuction():
	UnitManager.registerBase(self, "player")
	isConstructed = true
	constuctionTimer.stop()
	StationSprite.visible = true
	ConstuctionSprite.visible = false
	Inventory.enableTransportJobs()

func doesProcess(item):
	return false
	
func _on_ConstructionTimer_timeout():
	if isConstructed == false:
		if Inventory.removeFromInventory("metal", 1):
			currentConstructionMetalUsed = currentConstructionMetalUsed + 1 #Can't use ++ here cause of an error with compiler https://github.com/godotengine/godot/issues/19128
	if currentConstructionMetalUsed == constructionMetalNeeded:
		completeConstuction()
		
