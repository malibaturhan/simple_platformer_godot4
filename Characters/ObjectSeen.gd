class_name ObjectSeen

var object_exist : bool:
	set(value):
		object_exist = value
	get:
		return object_exist
		
var distance_to_object : float:
	set(value):
		distance_to_object = value
	get:
		return distance_to_object
		
var foe : bool = false
var object_name : String

func _init(exist: bool, distance : float, foe: bool, object_name: String) -> void:
	object_exist = exist
	distance_to_object = distance_to_object
	foe = foe
	object_name = object_name
