extends Node2D

var dragging = false
var selected = []
var dragStart = Vector2.ZERO
var selectRectangle = RectangleShape2D.new()

onready var selector = get_node("Selector")

func _ready():
	pass

func _process(delta):
	#Selector Logic
	#if mouse clicked initiate data
	#else if mouse click lifted find finall location and selecte units
	if Input.is_action_just_pressed("select"):
		dragging = true
		dragStart = get_global_mouse_position()
	elif dragging and Input.is_action_just_released("select"):
		dragging = false
		#Deselect previous units
		for unit in selected:
			unit.collider.deselect()
		selected = []
		
		#Create a box to find all units inside
		var dragEnd = get_global_mouse_position()
		selectRectangle.extents = (dragEnd - dragStart) / 2
		var space = get_world_2d().direct_space_state
		var query = Physics2DShapeQueryParameters.new()
		query.set_shape(selectRectangle)
		query.transform = Transform2D(0, (dragEnd + dragStart) / 2)
		selected  = space.intersect_shape(query)
		
		#Call the "select()" method on all units found
		for unit in selected:
			unit.collider.select()
		selector.update_status(dragStart, dragEnd, dragging)
		
	if dragging:
		selector.update_status(dragStart, get_global_mouse_position(), dragging)
