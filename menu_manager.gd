extends Node

@onready var pause_menu: Control = $PauseMenu
var paused = false

signal game_state_change

func _ready() -> void:
	pause_menu.visible = paused
	game_state_change.connect(do_state_change_actions)
	
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		paused = !paused
		game_state_change.emit()
		print("game state change emitted")
		
func do_state_change_actions():
	print("state change actions RUN")
	if paused:
		pause_menu.visible = true
		Engine.time_scale = 0
	else:
		pause_menu.visible = false
		Engine.time_scale = 1
		
