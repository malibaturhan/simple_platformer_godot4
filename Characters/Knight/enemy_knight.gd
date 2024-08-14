extends Enemy


func _physics_process(delta: float) -> void:
	action_for_state()
	check_surrounding()
	check_ground(delta)
	apply_gravity(delta)
	movement()
	move_and_slide()


