class_name ScreenWrap

extends Node2D

## Wraps its parent position around the viewport's dimensions [br][br]
## This only works while not using a Camera2D, or if the Camera2D's 
## position and dimensions are equivalent to the viewport rect.

## The parent node to be moved. Must be a Node2D.
@onready var parent: Node2D = get_parent()


func _process(_delta):
	if not parent or not(parent is Node2D):
		return
	
	var screen = get_viewport_rect()
	
	parent.global_position.x = wrapf(
		parent.global_position.x,
		0, screen.size.x
	)
	parent.global_position.y = wrapf(
		parent.global_position.y,
		0, screen.size.y
	)
	
	print(parent.global_position)
	
