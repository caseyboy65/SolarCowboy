extends Node2D

var spinSpeed
export var clockWise = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if clockWise:
		spinSpeed = rng.randf_range(1, 10.0)
	else:
		spinSpeed = rng.randf_range(-10.0, 10.0)
	rotation_degrees = rng.randf_range(0, 360)


func _process(delta):
	var newRotation = rotation_degrees + spinSpeed * delta
	if newRotation > 360:
		newRotation -= 360
	elif newRotation < -360:
		newRotation += 360
	rotation_degrees = newRotation
