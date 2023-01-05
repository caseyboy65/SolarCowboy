extends KinematicBody2D

#Ship Stats
var maxSpeed = 200
var acceleration = 30
var turnSpeed : int = 1

#UI Vars
var isSelected = false

#Moving Vars
var currentJob : Node2D = null
var unloadDestination
var isMovingToMine = false
var isMovingToBase = false
var direction : int = 0
var currentSpeed = 0
var isMovingSound = false
var destination : Vector2 = Vector2()

#Mining vars
var jobTime = 1
var isMining = false
var isUnloading = false
var isTimerStarted = false

onready var jobTimer : Timer = get_node("JobTimer")
onready var engineSound : AudioStreamPlayer2D = get_node("EngineSound")
onready var drillSound : AudioStreamPlayer2D = get_node("DrillSound")
onready var unloadSound : AudioStreamPlayer2D = get_node("UnloadSound")
onready var sprite : Sprite = get_node("Ship")
onready var selector : Sprite = get_node("Ship").get_node("Selector")
onready var Inventory = get_node("Inventory")

# Called when the node enters the scene tree for the first time.
func _ready():
	UnitManager.registerMiner(self, "player")
	Inventory.visible = false
	Inventory.updateMaxInventory(1)

func _physics_process(delta):
	if currentJob == null:
		getJob()
	
	if isMovingToMine || isMovingToBase:
		if !isMovingSound:
			isMovingSound = true
			engineSound.play()
		rotateToTarget(destination, delta)
		currentSpeed += delta * acceleration
		position = position.move_toward(destination, delta * currentSpeed)
		if position == destination && isMovingToMine:
			isMovingToMine = false
			isMining = true
			currentSpeed = 0
			isMovingSound = false
			engineSound.stop()
		elif position == destination && isMovingToBase:
			isMovingToBase = false
			isUnloading = true
			currentSpeed = 0
			isMovingSound = false
			engineSound.stop()
	
	if isMining:
		if !isTimerStarted:
			isTimerStarted = true
			jobTimer.start(jobTime)
			drillSound.play()
			
	if isUnloading:
		if !isTimerStarted:
			isTimerStarted = true
			jobTimer.start(jobTime)
			unloadSound.play()

func getJob():
	currentJob = UnitManager.getMinerJob("player")
	if currentJob != null:
		destination = currentJob.global_position
		isMovingToMine = true
		
func rotateToTarget(location, delta):
	var direction = (location - global_position)
	var angleTo = sprite.transform.x.angle_to(direction)
	sprite.rotate(sign(angleTo) * min(delta * turnSpeed, abs(angleTo)))

func select():
	isSelected = true
	Inventory.visible = true
	selector.visible = true

func deselect():
	isSelected = false
	Inventory.visible = false
	selector.visible = false


func _on_JobTimer_timeout():
	if isMining:
		isTimerStarted = false
		isMining = false
		drillSound.stop()
		isMovingToBase = true
		unloadDestination =  UnitManager.findNearestBase(global_position, "player")
		destination = unloadDestination.get_transform().get_origin()
		currentJob.getInventory().removeFromInventory("ore", Inventory.getMaxInventoryLimit())
		print("Miner collected Ore")
		Inventory.addToInventory("ore", Inventory.getMaxInventoryLimit())
	elif isUnloading:
		isTimerStarted = false
		isUnloading = false
		isMovingToMine = true
		destination = currentJob.global_position
		unloadSound.stop()
		Inventory.removeFromInventory("ore", Inventory.getMaxInventoryLimit())
		unloadDestination.getInventory().addToInventory("ore", Inventory.getMaxInventoryLimit())
