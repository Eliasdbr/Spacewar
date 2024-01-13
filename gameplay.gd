extends Node2D

@export var PLAYER_COLORS = [
	Color("#0080ff"),
	Color("#ff3333"),
	Color("#4cff00"),
	Color("#ffea00"),
]

@export_range(1,4) var players_amount = 2

func _ready():
	# Pick random seed for RNG
	randomize()
	# Spawns the player(s)
	for p in range(players_amount):
		requestRandomPlayerSpawn(p+1, 1.0, PLAYER_COLORS[p])
	

## Looks for a random available place for a player to spawn
## Aditionally, a delay in seconds can be assigned
func requestRandomPlayerSpawn(
	player_number: int,
	delay: float = 0.0,
	color: Color = Color.from_hsv(randf(), 0.8, 1.0)
):
	await get_tree().create_timer(delay).timeout
	# Gets all the spawners
	var spawnables = get_tree().get_nodes_in_group("spawners")
	# Filters for available player spawners
	var player_spawnables = spawnables.filter(
		func(spawner): 
			return (spawner is PlayerSpawner) and not spawner.is_spawning
	)
	var selected_spawner = player_spawnables.pick_random()
	if selected_spawner:
		selected_spawner.player_number = player_number
		selected_spawner.spawner_color = color
		selected_spawner.request_spawn()

