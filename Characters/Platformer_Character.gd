class_name PlatformerCharacter
extends CharacterBody2D

signal state_change(new_state: StateMachine.States)

@export var state_machine : StateMachine

var camera : Camera2D

@onready var front_obstacle_raycast 	: RayCast2D = $Facing/FrontObstacle
@onready var seeing_raycast 			: RayCast2D = $Facing/EnemyRaycast
@onready var front_raycast				: RayCast2D = $Facing/FrontRaycast
@onready var rear_raycast				: RayCast2D = $Facing/RearRaycast

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
	specific_inits()
	animated_sprite.attack_completed.connect(finish_attack)
	animated_sprite.jump_completed.connect(finish_jump)
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
		#print("direction changed on base class")
		direction_changed.emit(value.x)
	get:
		return direction
		

func specific_inits():
	# This is a virtual class to use of inherited classes
	pass

func apply_gravity(delta):
	if !is_on_floor():
		velocity.y += gravity_magnitude * delta

			
func check_ground(delta) -> bool:
	var is_on_ground : bool = false
	if !is_on_floor():
		coyote_time -= delta
	else:
		coyote_time = initial_coyote_time
		is_on_ground = true
	return is_on_ground

func try_jump():
	if coyote_time >= -0.1 or is_on_floor():
		_jump()
	else:
		print("cannot jump")
		
		
func _jump():
	print("jumping")
	velocity.y -= jump_force
	coyote_time = -1
	
func finish_jump():
	change_state(StateMachine.States.IDLE)

func try_attack():
	if can_attack:
		#print("attacked")
		attack()
		
func attack():
	#print("attacked")
	pass
	
func finish_attack():
	# This function will be overriden in enemy and player scripts
	print("attack finished")
	
	
		
func take_damage(amount: int):
	health -= amount
	taken_damage()
	
func taken_damage():
	#virtual class to deal things after taking damage accordingly (for player and enemy)
	pass

func add_this_character_to_camera_list() -> void:
	camera.add_platformer_character_to_camera_list(self)


func change_state(state: StateMachine.States):
	state_change.emit(state)
	
	
func action_for_state():
	if state_machine.active_state == StateMachine.States.IDLE:
		direction = Vector2(0, 0)  # Enemy remains stationary in IDLE
	if state_machine.active_state == StateMachine.States.CHASE:
		#print("initializing run speed")
		direction = Vector2(sign(direction.x) * 1 * run_speed, 0)
	if state_machine.active_state == StateMachine.States.WANDER:		
		if direction.x == 0:
			direction.x = walk_speed
		direction = Vector2(sign(direction.x) * walk_speed, 0)
	if state_machine.active_state == StateMachine.States.ATTACK:
		try_attack()
	if state_machine.active_state == StateMachine.States.JUMP:
		print("IN JUMP STATE")
		try_jump()
#
