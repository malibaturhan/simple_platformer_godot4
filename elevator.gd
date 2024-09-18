extends CharacterBody2D

@onready var area2d : Area2D = $Area2D
@onready var chain_sound: AudioStreamPlayer2D = $ChainSound

@export var final_offset: float
@export var speed: float = 15.0

var initial_y_position: float
var passed_y_position := 0.0
var elevator_can_run:bool = false
var is_elevator_running := false
var initial_direction : int


func _ready():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		elevator_can_run = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		elevator_can_run = false

func _process(delta: float) -> void:
	if elevator_can_run:
		if Input.is_action_just_pressed("interact"):
			initial_direction = sign(final_offset - global_position.y)
			is_elevator_running = true
			
func _physics_process(delta: float) -> void:
	check_sfx()
	if is_elevator_running:
		move_elevator(delta)
			
func check_sfx():
	if is_elevator_running and not chain_sound.playing:
		chain_sound.play()
	if chain_sound.playing and not is_elevator_running:
		chain_sound.stop()
			
func move_elevator(delta: float):
	var movement_amount = delta * speed
	passed_y_position += movement_amount
	printt("passed y position: ", passed_y_position)
	printt("final offset: ", final_offset)
	if passed_y_position >= abs(final_offset):
		is_elevator_running = false
	printt("is elevator running: ", is_elevator_running)
	global_transform.origin += Vector2.UP * movement_amount
