class_name PlayerUIManager
extends Node

@export var player : Player

@onready var player_health_label : Label = get_tree().get_first_node_in_group("PLAYER_HEALTH_LABEL")

func _ready() -> void:
	player_health_label.text = "%s / %s" %[str(player.health), str(player.max_health)]
	
func refresh():
	print("refresh called")
	player_health_label.text = "%s / %s" %[str(player.health), str(player.max_health)]
