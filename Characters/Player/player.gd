class_name Player
extends PlatformerCharacter

var ground_states = [StateMachine.States.IDLE, StateMachine.States.WANDER, StateMachine.States.ATTACK]
@export var player_ui_manager : PlayerUIManager

func _process(delta):
	action_for_state()
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity.x = direction.x  * run_speed
	if state_machine.active_state not in ground_states:
		if abs(direction.x) > 0 and is_on_floor():
			change_state(StateMachine.States.WANDER) 
		elif direction.x == 0 and is_on_floor():
			change_state(StateMachine.States.IDLE)


func _physics_process(delta: float) -> void:

	check_ground(delta)
	apply_gravity(delta)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		printt("JUMP BUTTON PRESSED", is_on_floor())
		change_state(StateMachine.States.JUMP)
	if event.is_action_pressed("attack"):
		change_state(StateMachine.States.ATTACK)
		
func taken_damage():
	player_ui_manager.refresh()
		

func finish_attack():
	print("attack finished")
	var enemy_striked
	enemy_striked = front_obstacle_raycast.get_collider()
	if enemy_striked == null:
		change_state(StateMachine.States.IDLE)
		print("PLAYER HIT EMPTY")
		return
	if enemy_striked.is_class("CharacterBody2D"):
		print("AI DAMAGED BY PLAYER")
		enemy_striked.take_damage(1) 
		change_state(StateMachine.States.IDLE)
	
