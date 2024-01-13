class_name Ship

extends Node2D

## For gravity
@export var mass := 1.0

@onready var movement = $Movement

var can_respawn = true

func _ready():
	rotation = randf_range(0.0, TAU)
	movement.velocity = movement.max_speed * 0.2 * Vector2.RIGHT.rotated(rotation)

func destroy():
	var explosion = preload("res://effects/explosion.tscn").instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
