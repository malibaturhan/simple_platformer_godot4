extends Area2D

@export var hint_text: String



func _on_body_entered(body: Node2D) -> void:
	if is_instance_of(body, CharacterBody2D):
		if body.name == "Player":
			body.get_hint_label().hint_text = hint_text
			body.get_hint_label().show_hint_label()


func _on_body_exited(body: Node2D) -> void:
	if is_instance_of(body, CharacterBody2D):
		if body.name == "Player":
			body.get_hint_label().hide_hint_label()
