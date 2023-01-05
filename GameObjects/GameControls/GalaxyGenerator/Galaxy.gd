extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var galaxyMap
var galaxySize = Vector2(100,100)
var starChance = .01
onready var spaceTiles = get_node("SpaceTiles")
onready var starTiles = get_node("StarTiles")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	GenerateGalaxy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func GenerateGalaxy():
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 1.0
	noise.period = 12
	GenerateSpace()
	GenerateStars()

func GenerateSpace():
	for x in galaxySize.x:
		for y in galaxySize.y:
			spaceTiles.set_cell(x,y,0)
	#spaceTiles.update_bitmask_region(Vector2(0.0,0.0), Vector2(galaxySize.x, galaxySize.y))

func GenerateStars():
	for x in galaxySize.x:
		for y in galaxySize.y:
			var random = rand_range(0, 1)
			var starType = randi()%4+0
			if random <= starChance:
				starTiles.set_cell(x,y,starType)
