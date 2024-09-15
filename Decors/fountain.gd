extends Interactable

@onready var debug_logger : DebugLogger = get_tree().get_first_node_in_group("DEBUG_LOGGER")

func _process(delta: float) -> void:
	if !is_interactable:
		return
	if Input.is_action_pressed("interact"):
		debug_logger.add_log("Player Healed")
		print(interactable_body.health)
		interactable_body.heal()
