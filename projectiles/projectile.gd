class_name Projectile

extends Node2D

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.RIGHT
@export var range: float = 1000.0 # in pixels

@onready var movement: Movement = $Movement

var owner_ship: Ship = null
var distance_reached: float = 0.0

func _ready():
	movement.velocity = direction.normalized() * speed

func _process(delta):
	if distance_reached >= range:
		queue_free()
	distance_reached += speed * delta
	

func _on_hitbox_area_entered(area: Area2D):
	# TODO: Add collision with other objects
	var other = area.get_parent()
	# Collision with a player ship
	if (
		area.get_collision_layer_value(2)
		and get_instance_id() != other.get_instance_id()
	):
		# TODO: add proper effects
		other.queue_free()
		queue_free()
	
