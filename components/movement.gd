class_name Movement
extends Node

## The parent node to be moved. Must be a Node2D.
@onready var parent: Node2D = null
## Top speed. -1.0 for no speed limit
@export var max_speed: float = 200.0
## How fast it stops by its own.
## 0.0 is no friction (like in space)
## 1.0 is full friction (immediately stops)
@export_range(0.0, 1.0) var friction_factor: float = 1.0
## Current velocity
@export var velocity: Vector2 = Vector2.ZERO
## Current acceleration. It will always be a normalized vector.
@export var acceleration: Vector2 = Vector2.ZERO


func _ready():
	parent = get_parent()
	if not parent or not(parent is Node2D):
		push_warning("Movement component: it needs a parent that exists and it has to be a Node2D")
		return
	#
#

func _process(delta):
	var current_speed = velocity.length()
	
	if acceleration.length() > 0.0:
		# Accelerates
		velocity += acceleration
	else:
		# Decelerates
		velocity = lerp(velocity, Vector2.ZERO, friction_factor)
		if current_speed < friction_factor:
			velocity = Vector2.ZERO
	
	# Caps the velocity if exceeded the max_speed
	if current_speed > max_speed: 
		velocity = velocity.normalized() * max_speed
	
	# Move the parent
	parent.global_position += velocity * delta
#
