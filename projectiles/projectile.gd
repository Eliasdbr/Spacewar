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
	var first_collision: Area2D = area.get_overlapping_areas().front() as Area2D
	var other = first_collision.get_parent()
	# Collision with a player ship
	if (first_collision.get_collision_layer_value(2)
	and not(other != owner_ship)):
		# TODO: add proper effects
		other.queue_free()
