class_name Projectile

extends Node2D

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.RIGHT
@export var p_range: float = 1000.0 # in pixels
## For gravity
@export var mass := 1.0

@onready var movement: Movement = $Movement
@onready var line_2d = $Line2D

var owner_ship: Ship = null
var distance_reached: float = 0.0
var damage: float = 1.0

func _ready():
	movement.velocity = direction.normalized() * speed
	if (owner_ship and owner_ship is Ship):
		var ship_movement = owner_ship.find_child("Movement")
		movement.velocity += ship_movement.velocity

func _process(delta):
	line_2d.points[1] = -movement.velocity * delta * 2.0
	if distance_reached >= p_range:
		queue_free()
	distance_reached += speed * delta
	

func _on_hitbox_area_entered(area: Area2D):
	# TODO: Add collision with other objects
	var other = area.get_parent()
	# Collision with a player ship
	if area.get_collision_layer_value(1):
		queue_free()
	if area.get_collision_layer_value(2):
		if owner_ship and owner_ship.get_instance_id() == other.get_instance_id():
			return
		# TODO: add proper effects
		other.destroy()
		queue_free()
	
