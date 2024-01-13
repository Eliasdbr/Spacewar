extends Control

@onready var player_label = %PlayerLabel
@onready var score_label = %ScoreLabel
@onready var margin_container = %MarginContainer

@export_range(1,4) var player_number := 1

@export var score := 0:
	set(value):
		score = value
		score_label.text = "Score: " + str(score)

func _ready():
	player_label.text = "Player " + str(player_number)
	score_label.text = "Score: " + str(score)
	if (player_number % 2 == 0):
		margin_container.anchor_right = 0.0
