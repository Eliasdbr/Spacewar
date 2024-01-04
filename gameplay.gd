extends Node2D

func _ready():
	# Spawnables
	var spawnables = get_tree().get_nodes_in_group("spawners")
	for spawner_node in spawnables:
		spawner_node.request_spawn()
	
