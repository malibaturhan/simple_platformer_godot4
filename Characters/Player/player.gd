class_name Player
extends PlatformerCharacter

var ground_states = [StateMachine.States.IDLE, StateMachine.States.WANDER, StateMachine.States.ATTACK]
@export var player_ui_manager : PlayerUIManager
@export var hint_label:Label

func _process(delta):
	action_for_state()
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity.x = direction.x  * run_speed
	if state_machine.active_state != StateMachine.States.ATTACK:
		if abs(direction.x) > 0 and is_on_floor():
			change_state(StateMachine.States.WANDER) 
		elif direction.x == 0 and is_on_floor():
			change_state(StateMachine.States.IDLE)
	if state_machine.active_state == StateMachine.States.ATTACK and abs(direction.x) > 0:
		change_state(StateMachine.States.WANDER) 
	if Input.is_action_pressed("jump") and state_machine.active_state != StateMachine.States.JUMP:
		change_state(StateMachine.States.START_JUMP)
	if Input.is_action_pressed("attack"):
		change_state(StateMachine.States.ATTACK)
		

func _physics_process(delta: float) -> void:
	check_ground(delta)
	apply_gravity(delta)
	move_and_slide()
#
func taken_damage():
	player_ui_manager.refresh()
	
func healed():
	player_ui_manager.refresh()
	
func get_hint_label():
	return hint_label

func finish_attack():
	var enemy_striked
	enemy_striked = front_obstacle_raycast.get_collider()
	if enemy_striked == null:
		change_state(StateMachine.States.IDLE)
		return
	if enemy_striked.is_class("CharacterBody2D"):
		enemy_striked.take_damage(1) 
		change_state(StateMachine.States.IDLE)
	
