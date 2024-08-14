extends Node

signal debug_active(bool)

var activated_debug :bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("activate_debug_tools"):
		activated_debug = !activated_debug
		debug_active.emit(activated_debug)
