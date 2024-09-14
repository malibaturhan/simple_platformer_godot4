extends Node

@export var teleport_locations_parent : Node

func _ready() -> void:
	create_buttons()
	
func create_buttons():
	for node in teleport_locations_parent.get_children():
		var new_button = Button.new()
		new_button.text = node.name
		self.add_child(new_button)
		new_button.button_up.connect(teleport.bind(node.global_transform))
		print("signals are bound")

func teleport(location: Vector2):
	printt("teleported to %s" %[str(location)])
