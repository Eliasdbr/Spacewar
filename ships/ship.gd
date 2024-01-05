class_name Ship

extends Node2D

## For gravity
@export var mass := 1.0

func _ready():
	rotation = randf_range(0.0, TAU)
	
