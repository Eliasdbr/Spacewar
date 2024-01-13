extends Control

@onready var player_label = %PlayerLabel
@onready var score_label = %ScoreLabel
@onready var margin_container = %MarginContainer

@export_range(1,4) var player_number := 1

@export var score := 0:
	set(value):
		score = value
		score_label.text = "Score: " + str(score)

@export var text_color := Color.WHITE

func _ready():
	player_label.text = "Player " + str(player_number)
	player_label.add_theme_color_override("font_shadow_color", text_color)
	score_label.text = "Score: " + str(score)
	score_label.add_theme_color_override("font_shadow_color", text_color)
	match (player_number):
		1:
			anchors_preset = PRESET_TOP_LEFT
			margin_container.anchors_preset = PRESET_TOP_LEFT
		2:
			anchors_preset = PRESET_TOP_RIGHT
			margin_container.anchors_preset = PRESET_TOP_RIGHT
		3:
			anchors_preset = PRESET_BOTTOM_LEFT
			margin_container.anchors_preset = PRESET_BOTTOM_LEFT
		4:
			anchors_preset = PRESET_BOTTOM_RIGHT
			margin_container.anchors_preset = PRESET_BOTTOM_RIGHT
