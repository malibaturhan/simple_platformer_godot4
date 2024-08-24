class_name CharacterParticleController
extends Node

@export var character : PlatformerCharacter

@export_group("Character Particles")
@export var walking_dust_particle: GPUParticles2D


func _ready() -> void:
	walking_dust_particle.emitting = false

func _physics_process(delta: float) -> void:
	if character.direction.x == 0 or !character.is_on_floor():
		walking_dust_particle.emitting = false
	else:
		walking_dust_particle.emitting = true
