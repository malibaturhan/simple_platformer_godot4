extends Area2D

@export var win_screen: Control

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		win_screen.visible = true
		#Engine.time_scale = 0.8
