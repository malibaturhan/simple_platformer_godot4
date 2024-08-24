class_name DebugLogger
extends RichTextLabel

signal log_queue_changed

var queue: Array[String]

@export var queue_length := 10

func _ready() -> void:
	text = ""
	log_queue_changed.connect(_update_text)
	add_log("Game started")
	print("debug logger is ready")
	
func add_log(log_to_add: String) -> void:
	queue.append(log_to_add + "\n")
	if len(queue) > queue_length:
		queue.pop_back()
	log_queue_changed.emit()
	
func _update_text():
	print("debug text updated")
	for i in range(len(queue)):
		text += queue[i]
		
