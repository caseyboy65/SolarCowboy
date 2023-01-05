extends Node2D


var currentBuilding


# Called when the node enters the scene tree for the first time.
func _ready():
	currentBuilding = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentBuilding != null:
		var mousePosition = get_global_mouse_position()
		currentBuilding.position = mousePosition
	if Input.is_mouse_button_pressed(1) &&  currentBuilding != null:
		currentBuilding.startConstruction()
		currentBuilding = null
	elif Input.is_mouse_button_pressed(2) &&  currentBuilding != null:
		remove_child(currentBuilding)
		currentBuilding = null
		

func _on_Outpost_pressed():
	var scene = load("res://GameObjects/Stations/Outpost/Outpost.tscn")
	currentBuilding = scene.instance()
	currentBuilding.set_name("Outpost")
	add_child(currentBuilding)
