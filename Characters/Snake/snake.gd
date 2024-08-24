extends Enemy


func _physics_process(delta: float) -> void:
	action_for_state()
	if state_machine.active_state != StateMachine.States.DYING:
		check_surrounding()
		check_ground(delta)
		apply_gravity(delta)
		movement()
		move_and_slide()


func _on_starting_to_wander_timeout() -> void:
	change_state(StateMachine.States.WANDER)
