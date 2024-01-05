extends Area2D

@export var mass := 2000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var gravity_nodes = get_tree().get_nodes_in_group("gravity_affected") as Array[Node2D]
	for node in gravity_nodes:
		var node_mass = node.mass
		var node_movement = node.find_child("Movement") as Movement
		var direction = node.global_position.direction_to(global_position)
		var distance = node.global_position.distance_to(global_position)
		var grav = (mass * node_mass) / distance
		node_movement.velocity += direction * delta * grav
