extends RigidBody2D

@onready var area2d : Area2D = $Area2D

@export var final_offset: float
@export var speed: float = 5.0

var initial_y_position: float
var passed_y_position := 0.0
var elevator_can_run:bool = false
var is_elevator_running := false
var initial_direction : int


func _ready():
	initial_y_position = global_position.y
	

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
	if is_elevator_running:
		move_elevator()
			
func move_elevator():
	apply_force(Vector2.UP * speed)
