class_name Weapon

extends Node

enum TRIGGER {
	## Like a pistol. Only shoots after releasing and pressing the <shoot> key.
	Semiautomatic,
	## Like a machine gun. Keeps shooting as long as the <shoot> key is pressed.
	Automatic
}

## Projectile scene
@export var projectile: PackedScene = null
@export_group("Stats")
## Damage in hit points.
@export var damage: float = 1.0
## Shooting cooldown in milliseconds.
@export var cooldown: float = 1000.0
## Range in pixels.
@export var w_range: float = 1000.0
## Trigger mode.
@export var trigger_mode: TRIGGER = TRIGGER.Semiautomatic

## Parent.
@onready var parent: Node2D = get_parent()
## Environment. Where the projectile will be placed.
@onready var environment = get_node("/root/Main/Gameplay/Environment")

## Current cooldown
var current_cooldown = 0.0

func _process(delta):
	if not parent or not(parent is Node2D):
		return
	if current_cooldown < 0.0:
		current_cooldown = 0.0
	else:
		current_cooldown -= delta * 1000

func shoot():
	if (
		not parent 
		or not(parent is Node2D) 
		or not projectile
		or current_cooldown > 0.0
	):
		return
	# Creates the projectile
	var new_proj = projectile.instantiate() as Projectile
	# Sets up the projectile
	new_proj.damage = damage
	new_proj.p_range = w_range
	new_proj.global_position = parent.global_position
	new_proj.direction = Vector2.RIGHT.rotated(parent.rotation)
	new_proj.owner_ship = parent
	# Adds the projectile to the world
	environment.add_child(new_proj)
	# Resets the cooldown counter
	current_cooldown = cooldown
