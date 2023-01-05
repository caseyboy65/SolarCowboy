extends KinematicBody2D

#Ship Stats
var maxSpeed = 200
var acceleration = 30
var turnSpeed : int = 1

#UI Vars
var isSelected = false

#Moving Vars
var currentJob
var unloadDestination
var isMovingToJob = false
var isMovingToBase = false
var direction : int = 0
var currentSpeed = 0
var isMovingSound = false
var destination

#Transport vars
enum JobStates {
  PICKINGUP,
  LOADING,
  DELIVERING,
  UNLOADING,
  COMPLETE,
}
var jobTime = 1
var currentJobState;

onready var jobTimer : Timer = get_node("JobTimer")
#onready var engineSound : AudioStreamPlayer2D = get_node("EngineSound")
#onready var drillSound : AudioStreamPlayer2D = get_node("DrillSound")
#onready var unloadSound : AudioStreamPlayer2D = get_node("UnloadSound")
onready var sprite : Sprite = get_node("Sprite")
#onready var selector : Sprite = get_node("Ship").get_node("Selector")

onready var Inventory = get_node("Inventory")

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory.visible = false
	Inventory.updateMaxInventory(1)
	#UnitManager.registerTransport(self, "player")

func _physics_process(delta):
	if currentJob == null || currentJobState == JobStates.COMPLETE:
		currentJob = UnitManager.getJob([UnitManager.JobTypes.SUPPLY, UnitManager.JobTypes.TRANSPORT])
	if destination == null && currentJob != null:
		if currentJob.type == UnitManager.JobTypes.SUPPLY:
			print("Starting Supply Job")
			destination = UnitManager.findNearestBaseWithResource(global_position, "player", currentJob.resource, 1)
		elif currentJob.type == UnitManager.JobTypes.TRANSPORT:
			print("Starting Transport Job")
			destination = currentJob.target
		currentJobState = JobStates.PICKINGUP
	if destination != null:
		rotateToTarget(destination.position, delta)
		currentSpeed += delta * acceleration
		position = position.move_toward(destination.position, delta * currentSpeed)
		if position == destination.position:
			if currentJobState == JobStates.PICKINGUP:
				currentJobState = JobStates.LOADING
				currentSpeed = 0
				jobTimer.start(jobTime)
			if currentJobState == JobStates.DELIVERING:
				currentJobState = JobStates.UNLOADING
				currentSpeed = 0
				jobTimer.start(jobTime)

func rotateToTarget(location, delta):
	var direction = (location - global_position)
	var angleTo = sprite.transform.x.angle_to(direction)
	sprite.rotate(sign(angleTo) * min(delta * turnSpeed, abs(angleTo)))

func select():
	isSelected = true
	#selector.visible = true
	Inventory.visible = true

func deselect():
	isSelected = false
	#selector.visible = false
	Inventory.visible = false

func _on_JobTimer_timeout():
	if currentJobState == JobStates.LOADING:
		print("Loading Ship with" + currentJob.resource)
		destination.getInventory().removeFromInventory(currentJob.resource, 1)
		Inventory.addToInventory(currentJob.resource, 1)
		currentJobState = JobStates.DELIVERING	
		if currentJob.type == UnitManager.JobTypes.SUPPLY:
			destination = currentJob.target
		elif currentJob.type == UnitManager.JobTypes.TRANSPORT:
			destination = UnitManager.findNearestBaseToProcessResource(global_position, currentJob.resource)
	if currentJobState == JobStates.UNLOADING:
		destination.getInventory().addToInventory(currentJob.resource, 1)
		Inventory.removeFromInventory(currentJob.resource, 1)
		currentJobState = JobStates.COMPLETE
		currentJob = null
		destination = null
