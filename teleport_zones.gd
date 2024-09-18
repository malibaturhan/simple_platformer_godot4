extends Node

@export var teleport_locations_parent : Node
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("PLAYER")

var is_visible = false

func _ready() -> void:
	self.visible = is_visible
	create_buttons()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_menu"):
		is_visible = not is_visible
		self.visible = is_visible
	
	
func teleport(location: Transform2D):
	printt("teleported to %s" %[str(location.origin)])
	player.global_transform.origin = location.origin


func create_buttons():
	for node in teleport_locations_parent.get_children():
		var new_button = Button.new()
		new_button.text = node.name
		new_button.pressed.connect(teleport.bind(node.global_transform))
		self.add_child(new_button)
