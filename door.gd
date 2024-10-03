extends StaticBody2D

@onready var debug_logger : DebugLogger = get_tree().get_first_node_in_group("DEBUG_LOGGER")
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var is_open:bool:
	set(val):
		if val == false:
			is_open = val
		else:
			is_open = val
			remove_door()
			
			
func remove_door():
	debug_logger.add_log("door removed")
	get_tree().queue_delete(self)
