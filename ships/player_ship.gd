extends Ship

@export_range(1, 2) var player_number: int = 1
@export_color_no_alpha var line_color = Color(1.0, 1.0, 1.0)
@onready var tank_controls = $TankControls
@onready var out_line_2d = $OutLine2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#super()
	tank_controls.player = player_number
	out_line_2d.default_color = line_color
	#out_line_2d.default_color = line_color
