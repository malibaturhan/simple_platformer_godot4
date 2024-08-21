class_name Enemy
extends PlatformerCharacter

@onready var starting_to_wander: Timer = $StartingToWander

@onready var player : PlatformerCharacter = get_tree().get_first_node_in_group("PLAYER")


@onready var is_platform_on_front 		: bool
@onready var is_platform_on_rear 		: bool


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
		
func specific_inits():
	get_health_ui()
		
		
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


func see_surrounding():			# its enemy is player!
	var eye_saw = seeing_raycast.get_collider()				# Eye distance
	var ground_saw = front_raycast.get_collider()		# Checking if floor under next step
	var front_foot_saw = front_obstacle_raycast.get_collider()	# Checking obstacles preventing walk

	# Checking for direction change
	if !ground_saw or front_foot_saw:
		if eye_saw != player:
			direction.x *= -1
			
	# Checking for attack conditions
	if eye_saw:
		if eye_saw.name == player.name:
			var distance_to_player : float = (global_position - player.global_position).length()
			if distance_to_player <= attack_range:
				change_state(StateMachine.States.ATTACK)
			else:
				change_state(StateMachine.States.CHASE)
		else:
			change_state(StateMachine.States.WANDER)
	
	
func finish_attack():
	#print("attack finished")
	var enemy_striked
	enemy_striked = front_obstacle_raycast.get_collider()
	if enemy_striked == null:
		change_state(StateMachine.States.WANDER)
		return
	if enemy_striked == player:
		#print("PLAYER DAMAGED BY AI")
		player.take_damage(1) 
		
func get_health_ui():
	pass
	
