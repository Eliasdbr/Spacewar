class_name TankControls
extends Node

## Movement component
@export var movement: Movement = null
## Weapon component
@export var weapon: Weapon = null
## Ship Nozzle. It's a particle emitter.
@export var nozzle: CPUParticles2D = null
## Player number.
@export_range(1, 2) var player: int = 1
## Rotation speed in radians per second.
@export var rotation_speed: float = PI
## Parent. A Node2D that this controls
@onready var parent: Node2D = null

## Parent orientation in radians
var rotation: float = 0.0
## Parent's Throttle Sound Node
var throttle_sound: AudioStreamPlayer

func _ready():
	if not movement:
		push_warning("TankControls: It needs a Movement component")
		return
	parent = get_parent()
	if not parent or not(parent is Node2D):
		push_warning("TankControls: it needs a parent that exists and it has to be a Node2D")
		return
	#
	throttle_sound = parent.get_node("ThrottleSound")
#

func _process(delta):
	if not parent or not(parent is Node2D):
		return
	
	var rotation_input = Input.get_axis(
		"p"+str(player)+"_rotate_ccw", 
		"p"+str(player)+"_rotate_cw"
	)
	var throttling = Input.is_action_pressed("p"+str(player)+"_thrust")
	var shooting: bool = false
	if weapon:
		if weapon.trigger_mode == weapon.TRIGGER.Semiautomatic:
			shooting = Input.is_action_just_pressed("p"+str(player)+"_shoot")
		else:
			shooting = Input.is_action_pressed("p"+str(player)+"_shoot")
	
	# Sets rotation
	rotation = rotation_input * rotation_speed * delta
	parent.rotate(rotation)
	
	# Forward movement
	movement.acceleration = (
		Vector2.RIGHT.rotated(parent.global_rotation) * float(throttling) * 1.0
	)
	# Particles effect
	if nozzle and throttling: nozzle.emitting = true
	
	# Throttle sound:
	if throttle_sound:
		if Input.is_action_just_pressed("p"+str(player)+"_thrust"):
			throttle_sound.playing = true
		if Input.is_action_just_released("p"+str(player)+"_thrust"):
			throttle_sound.playing = false
	
	# Shooting
	if weapon and shooting:
		weapon.shoot()
#
