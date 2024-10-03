extends Node2D

@export var object_to_reset:Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		object_to_reset.reset()
