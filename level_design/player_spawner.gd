extends Spawner

@export var player_number: int = 1

const PLAYER_SHIP = preload("res://ships/player_ship.tscn")

func spawn():
	if context:
		var ship = PLAYER_SHIP.instantiate() as PlayerShip
		ship.global_position = global_position
		ship.player_number = player_number
		ship.line_color = spawner_color
		context.add_child(ship)
