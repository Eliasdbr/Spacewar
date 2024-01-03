extends Ship

@export_range(1, 2) var player_number: int = 1

@onready var tank_controls = $TankControls


# Called when the node enters the scene tree for the first time.
func _ready():
	#super()
	tank_controls.player = player_number

