class_name PlayerShip

extends Ship

@export_range(1, 4) var player_number: int = 1
@export_color_no_alpha var line_color = Color(1.0, 1.0, 1.0)
@onready var tank_controls = $TankControls
@onready var out_line_2d = $OutLine2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	tank_controls.player = player_number
	out_line_2d.default_color = line_color
	#out_line_2d.default_color = line_color

# Called after dying
func destroy():
	if can_respawn:
		var gameplay_node = $"/root/Main/Gameplay"
		if gameplay_node.has_method("requestRandomPlayerSpawn"):
			gameplay_node.requestRandomPlayerSpawn(player_number, 2.0, line_color)
	super()

## Adds score
func addScore(amount: int = 1):
	score += amount
	var player_score_label = get_node(
		"/root/Main/Gameplay/UI/Player" 
		+ str(player_number) 
		+ "Indicator"
	)
	if player_score_label: player_score_label.score = score
