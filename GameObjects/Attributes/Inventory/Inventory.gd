extends Node2D

var inventory = {}
var maxInventoryLimit = 1000
var currentInventorySpace = 0
var transportJobsEnabled = false
var inventoryOwner

onready var inventoryUI = get_node("InventoryUI")
onready var MaxSize = get_node("MaxSizeValue")
onready var CurrentSize = get_node("CurrentSizeValue")


# Called when the node enters the scene tree for the first time.
func _ready():
	MaxSize.text = str(maxInventoryLimit)

func enableTransportJobs():
	transportJobsEnabled = true
func disableTransportJobs():
	transportJobsEnabled = false
func updateMaxInventory(newSize):
	maxInventoryLimit = newSize
	MaxSize.text = str(maxInventoryLimit)
func updateInventoryOwner(object):
	inventoryOwner = object

func getMaxInventoryLimit():
	return maxInventoryLimit

func addToInventory(item, amount):
	if (currentInventorySpace + amount > maxInventoryLimit):
		return false
	else:
		currentInventorySpace += amount
	if item in inventory:
		inventory[item] += amount
	else:
		inventory[item] = amount
	if transportJobsEnabled:
		var jobData = {}
		jobData.resource = item
		jobData.target = inventoryOwner
		jobData.type = UnitManager.JobTypes.TRANSPORT
		UnitManager.createJob(jobData)
	print("Adding to Inventory")
	updateInventoryUI()
	
func removeFromInventory(item, amount):
	if item in inventory:
		if inventory[item] >= amount:
			inventory[item] -= amount
			currentInventorySpace -= amount
			updateInventoryUI()
			return true
	return false
		
func hasInventory(item, amount):
	if item in inventory:
		if inventory[item] >= amount:
			return true
	return false

func updateInventoryUI():
	inventoryUI.clear()
	for item in inventory:
		inventoryUI.add_item(item + " : " + str(inventory[item]))
	CurrentSize.text = str(currentInventorySpace)
