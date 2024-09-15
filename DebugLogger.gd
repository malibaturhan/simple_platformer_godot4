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
	log_to_add = "%s\n" %log_to_add
	var q_temp: Array[String] = []
	q_temp.append(log_to_add)
	q_temp.append_array(queue)
	queue = q_temp
	if len(queue) > queue_length:
		queue.pop_back()
	log_queue_changed.emit()
	
# Instead of the things I did above I could reverse for loop below but this is a good reminder of my fault so it stays
func _update_text():
	text = ""
	for i in range(len(queue)):
		text += queue[i]
		
