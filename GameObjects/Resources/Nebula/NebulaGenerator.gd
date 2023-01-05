extends Node2D

onready var sprite : Sprite = get_node("Nebula") 
var colorRange = .3

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var numberOfClouds = rng.randf_range(0, 10.0)
	var red = rng.randf_range(0, 1)
	var blue = rng.randf_range(0, 1)
	var green = rng.randf_range(0, 1)
	var tansparency = rng.randf_range(0, 1)
	print("Red : " + str(red))
	print("Blue : " + str(blue))
	print("Green : " + str(green))
	
	sprite.modulate = Color(red, blue, green, tansparency)
	
	for n in numberOfClouds:
		var newCloud = sprite.duplicate()
		get_parent().remove_child(newCloud)
		add_child(newCloud)
		var newColorRange = rng.randf_range(-colorRange, colorRange)
		var newRed = red + (red * newColorRange)
		var newBlue = blue + (blue * newColorRange)
		var newGreen = green + (green * newColorRange)
		tansparency = rng.randf_range(0, 1)
		var randomXLoc =  rng.randf_range(-100, 100)
		var randomyLoc =  rng.randf_range(-100, 100)
		newCloud.position += Vector2(randomXLoc,randomyLoc)
		print("NewRed : " + str(newRed))
		print("NewBlue : " + str(newBlue))
		print("NewGreen : " + str(newGreen))
		newCloud.modulate = Color(newRed, newBlue, newGreen, tansparency)
