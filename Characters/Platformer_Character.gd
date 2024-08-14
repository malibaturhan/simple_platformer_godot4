class_name PlatformerCharacter
extends CharacterBody2D

signal state_change(new_state: StateMachine.States)

@export var state_machine : StateMachine

var camera : Camera2D

var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: CharacterAnimation = $Facing/AnimatedSprite2D

@export var run_speed 			: float = 15.0
@export var walk_speed 			: float = 5.0
@export var jump_force 			: float = 150
@export var initial_coyote_time : float = 0.4
@export var can_attack			: bool = true
var coyote_time 				: float

@export var health : int:
	set(value):
		health = value
	get:
		return health

signal direction_changed(direction: float)

func _ready() -> void:
	animated_sprite.attack_completed.connect(finish_attack)
	coyote_time = initial_coyote_time
	camera = get_tree().get_first_node_in_group("PLAYER_CAMERA")
	add_this_character_to_camera_list()
	# Game starts with idle
	change_state(StateMachine.States.IDLE)
	
var direction : Vector2 :
	set(value):
		if direction == value:
			return
		direction = value
		print("direction changed on base class")
		direction_changed.emit(value.x)
	get:
		return direction

func apply_gravity(delta):
	if !is_on_floor():
		velocity.y += gravity_magnitude * delta
		change_state(StateMachine.States.JUMP) 

			
func check_ground(delta) -> bool:
	var is_on_ground : bool = false
	if !is_on_floor():
		coyote_time -= delta
	else:
		coyote_time = initial_coyote_time
		is_on_ground = true
	return is_on_ground

func try_jump():
	if coyote_time >= -0.1:
		_jump()
		
		
func _jump():
	#print("jumping")
	velocity.y -= jump_force
	coyote_time = -1

func try_attack():
	if can_attack:
		print("attacked")
		attack()
		
func attack():
	change_state(StateMachine.States.ATTACK) 
	print("attacked")
	
func finish_attack():
	print("attack finished")
	change_state(StateMachine.States.IDLE)
		
func take_damage(amount: int):
	health -= amount

func add_this_character_to_camera_list() -> void:
	camera.add_platformer_character_to_camera_list(self)


func change_state(state: StateMachine.States):
	state_change.emit(state)
