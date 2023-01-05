extends Node

var maxNumberOfSolarSystems = 100
var distanceInterval = 10000


# Called when the node enters the scene tree for the first time.
func _ready():
	GenerateGalaxy()

func GenerateGalaxy():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var currentNumberOfSolarSystems = rng.randi_range(1, maxNumberOfSolarSystems)
	for x in maxNumberOfSolarSystems:
		var newSystem = SolarSystemGenerator.GenerateSolarSystem()
		var newXLoc = rng.randi_range(0, 1)
		if newXLoc == 0:
			newXLoc = -1
		var newYLoc = rng.randi_range(0, 1)
		if newYLoc == 0:
			newYLoc = -1
		newSystem.position = Vector2(newXLoc * distanceInterval * x,newYLoc * distanceInterval * x)
