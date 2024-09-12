extends Interactable

func _process(delta: float) -> void:
	if !is_interactable:
		return
	if Input.is_action_pressed("interact"):
		print("healing")
		print(interactable_body.health)
		interactable_body.heal()
