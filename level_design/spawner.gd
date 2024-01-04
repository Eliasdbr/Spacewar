class_name Spawner

extends Marker2D

@export var context: Node2D = null
@export var scene_to_spawn: PackedScene = null
@export var delay: float = 0.0
@export_color_no_alpha var spawner_color = Color.WHITE

@onready var suck_in_particles = $SuckInParticles

func spawn():
	if context and scene_to_spawn:
		var node_to_spawn = scene_to_spawn.instantiate()
		node_to_spawn.global_position = global_position
		context.add_child(node_to_spawn)

func request_spawn():
	suck_in_particles.lifetime = delay + 0.5
	var accel_factor = suck_in_particles.emission_sphere_radius / delay
	suck_in_particles.radial_accel_max = -accel_factor
	suck_in_particles.radial_accel_min = -accel_factor
	suck_in_particles.color = spawner_color
	suck_in_particles.emitting = true
	if delay > 0.0:
		await get_tree().create_timer(delay).timeout
	spawn()
	suck_in_particles.emitting = false
	
