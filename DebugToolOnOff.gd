extends Node

@onready var debug_controller = get_tree().get_first_node_in_group("DEBUG_CONTROLLER")

func _ready() -> void:
	_set_visible(debug_controller.activated_debug)
	debug_controller.debug_active.connect(_set_visible)
	
func _set_visible(val : bool):
	self.visible = val
