extends Node

var maxNumberOfStars = 1
var maxNumberOfPlanets = 9
var maxNumberOfAstoriods = 100
var maxSystemDistance = maxNumberOfPlanets * 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var currentNumberOfStars = rng.randi_range(1, maxNumberOfStars)
	var currentNumberOfPlanets = rng.randi_range(1, maxNumberOfPlanets)
	var currentNumberOfAstoriods = rng.randi_range(1, maxNumberOfAstoriods)
	var system = GenerateSolarSystem()
	GenerateStar(currentNumberOfStars, system)
	GeneratePlanets(currentNumberOfPlanets, system)
	GenerateAstoriods(currentNumberOfAstoriods, maxSystemDistance, system)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func GenerateSolarSystem():
	var asset = load("res://GameObjects/Resources/SolarSystem/SolarSystem.tscn")
	var newSystem = asset.instance()
	add_child(newSystem)
	return newSystem
	
func GenerateStar(total, system):
	for x in total:
		var asset = load("res://GameObjects/Resources/Star/Star.tscn")
		var newAsset = asset.instance()
		system.add_child(newAsset)
		#newStar.position = Vector2(100,100)

func GeneratePlanets(total, system):
	for x in total:
		var asset = load("res://GameObjects/Resources/Planet/Planet.tscn")
		var newAsset = asset.instance()
		system.add_child(newAsset)
		newAsset.position = Vector2(1000 * (x+1),0)
	
func GenerateAstoriods(total, distance, system):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for x in total:
		var asset = load("res://GameObjects/Resources/Asteroid/Asteroid.tscn")
		var newAsset = asset.instance()
		system.add_child(newAsset)
		var newXLoc = rng.randi_range(-distance, distance)
		var newYLoc = rng.randi_range(-distance, distance)
		newAsset.position = Vector2(newXLoc,newYLoc)
