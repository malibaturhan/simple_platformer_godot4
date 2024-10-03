extends AnimatedSprite2D

@onready var debug_logger : DebugLogger = get_tree().get_first_node_in_group("DEBUG_LOGGER")

@onready var area2d:Area2D = $Area2D
@onready var collect_sound: AudioStreamPlayer2D = $collect_sound
@onready var timer: Timer = $Timer

@export var related_door: StaticBody2D


func _ready() -> void:
	area2d.body_entered.connect(player_collected)
	
	
func player_collected(body: Node2D) -> void:
	debug_logger.add_log("Key received")
	related_door.is_open = true
	collect_sound.play()
	visible = false
	timer.start(2)
	


func _on_timer_timeout() -> void:
	get_tree().queue_delete(self)
