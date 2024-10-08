class_name Enemy
extends PlatformerCharacter

@onready var starting_to_wander: Timer = $StartingToWander

@onready var player : PlatformerCharacter = get_tree().get_first_node_in_group("PLAYER")
@onready var die_sfx: AudioStreamPlayer2D = $DieSFX

@export var health_ui : Control

@onready var is_platform_on_front 		: bool
@onready var is_platform_on_rear 		: bool

@export var repel_power : float = 100
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

func taken_damage():
	# refresh ui
	# activate damage shader
	# maybe flee or knockback
	if health == 0:
		die()

func play_death_sfx():
	die_sfx.play()

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
			
func repel_player(body):
	printt("body velocity: ", body.velocity)
	var repel_vector = (body.global_transform.origin - global_transform.origin).normalized()
	body.global_transform.origin += repel_vector
	body.velocity = repel_vector * repel_power
	
	
func finish_attack():
	var enemy_striked
	enemy_striked = front_obstacle_raycast.get_collider()
	if enemy_striked == null:
		change_state(StateMachine.States.WANDER)
		return
	if enemy_striked == player:
		player.take_damage(1) 
		
func get_health_ui():
	var parent_node = self
	var health_ui : Control
	for obj in self.get_children():
		if obj.is_in_group("ENEMY_HEALTH_UI"):
			obj.refresh(health)
			return
	
