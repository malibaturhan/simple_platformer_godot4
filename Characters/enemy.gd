class_name Enemy
extends PlatformerCharacter

@onready var player : PlatformerCharacter = get_tree().get_first_node_in_group("PLAYER")

@onready var seeing_raycast : RayCast2D = $Facing/EnemyRaycast
@onready var front_raycast: RayCast2D = $Facing/FrontRaycast
@onready var is_platform_on_front : bool
@onready var rear_raycast: RayCast2D = $Facing/RearRaycast
@onready var is_platform_on_rear : bool
@onready var front_obstacle_raycast : RayCast2D = $Facing/FrontObstacle

@export var seeable_range	: float = 5.0

@export var attack_range: float:
	set(value):
		attack_range = value
	get:
		return attack_range


var distance_to_player : float:
	set(value):
		distance_to_player = value
	get:
		return distance_to_player
		
		
func check_front() -> bool:
	if front_raycast.get_collider():
		return true
	return false
		
func check_rear() -> bool:
	if rear_raycast.get_collider():
		return true
	return false
	
func movement():
	velocity.x = direction.x * run_speed
	
func check_surrounding():
	see_surrounding()
		

func see_surrounding() -> ObjectSeen:			# its enemy is player!
	var obj = seeing_raycast.get_collider()
	var front_floor_object = front_raycast.get_collider()
	var obj_obstacle = front_obstacle_raycast.get_collider()
	if obj_obstacle == player:
		change_state(StateMachine.States.ATTACK)
	elif obj_obstacle or not front_floor_object:
		direction.x *= -1
	if obj:
		if obj is Player:
			print("Saw player")
			distance_to_player = abs((obj.global_position - global_position).length())
			var objSeen = ObjectSeen.new(true, distance_to_player, true, obj.name)
			if distance_to_player <= attack_range:
				change_state(StateMachine.States.ATTACK)
			elif state_machine.active_state != StateMachine.States.CHASE:
				change_state(StateMachine.States.CHASE)
			return objSeen
		if obj is TileMap:
			distance_to_player = abs((obj.global_position - global_position).length())
			var objSeen = ObjectSeen.new(true, distance_to_player, false, obj.name)
			if state_machine.active_state != StateMachine.States.WANDER:
				change_state(StateMachine.States.WANDER)
			return objSeen
		else:
			var objSeen = ObjectSeen.new(false, -1, false, obj.name)
			change_state(StateMachine.States.WANDER)
			return objSeen
	return null



	
func action_for_state():
	if state_machine.active_state == StateMachine.States.IDLE:
		direction = Vector2(0, 0)  # Enemy remains stationary in IDLE
	if state_machine.active_state == StateMachine.States.CHASE:
		print("initializing run speed")

		direction = Vector2(sign(direction.x) * 1 * run_speed, 0)
	if state_machine.active_state == StateMachine.States.WANDER:		
		direction.x = walk_speed
		direction = Vector2(sign(direction.x) * walk_speed, 0)
	if state_machine.active_state == StateMachine.States.ATTACK:
		try_attack()
#
