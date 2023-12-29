class_name TankControls
extends Node

## Movement component
@export var movement: Movement = null
## Player number.
@export_range(1, 2) var player: int = 1
## Rotation speed in radians per second.
@export var rotation_speed: float = PI
## Parent. A Node2D that this controls
@onready var parent: Node2D = null

## Parent orientation in radians
var rotation: float = 0.0

func _ready():
	if not movement:
		push_warning("TankControls: It needs a Movement component")
		return
	parent = get_parent()
	if not parent or not(parent is Node2D):
		push_warning("TankControls: it needs a parent that exists and it has to be a Node2D")
		return
	#
#

func _process(delta):
	if not parent or not(parent is Node2D):
		return
	
	var rotation_input = Input.get_axis(
		"p"+str(player)+"_rotate_ccw", 
		"p"+str(player)+"_rotate_cw"
	)
	var throttling = Input.is_action_pressed("p"+str(player)+"_thrust")
	var shooting = Input.is_action_just_pressed("p"+str(player)+"_shoot")
	
	# Sets rotation
	rotation = rotation_input * rotation_speed * delta
	parent.rotate(rotation)
	
	# Forward movement
	movement.acceleration = (
		Vector2.RIGHT.rotated(parent.global_rotation) * float(throttling) * 1.0
	)
#
