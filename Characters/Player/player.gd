class_name Player
extends PlatformerCharacter

func _process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity.x = direction.x  * run_speed
	if abs(velocity.x) > 0:
		change_state(StateMachine.States.WANDER) 
	

func _physics_process(delta: float) -> void:
	action_for_state()
	check_ground(delta)
	apply_gravity(delta)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		change_state(StateMachine.States.JUMP)
	if event.is_action_pressed("attack"):
		change_state(StateMachine.States.ATTACK)
		

