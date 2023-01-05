extends Camera2D

var moveSpeed : int = 5

var zoomSpeed = .2
var zoomChange = Vector2(zoomSpeed, zoomSpeed)
var zoomMin = Vector2(1, 1)
var zoomMax = Vector2(3, 3)
var desiredZoom = zoom

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
		# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				if zoom > zoomMin:
					desiredZoom -= zoomChange
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				if zoom < zoomMax:
					desiredZoom += zoomChange
			
func _process(delta):
	var newCameraPostion = position
	var newCameraZoom = zoom
	if Input.is_action_pressed("move_left"):
		newCameraPostion.x -= moveSpeed
	if Input.is_action_pressed("move_right"):
		newCameraPostion.x += moveSpeed
	if Input.is_action_pressed("move_up"):
		newCameraPostion.y -= moveSpeed
	if Input.is_action_pressed("move_down"):
		newCameraPostion.y += moveSpeed
	
	#zoom = zoom.move_toward(newCameraZoom, zoomSpeed)
	position = position.move_toward(newCameraPostion, moveSpeed)
	zoom = lerp(zoom, desiredZoom, zoomSpeed)
	
#	rotation += get_angle_to(get_global_mouse_position()) + 45 #TODO This doesn't seem to point to the mouse
