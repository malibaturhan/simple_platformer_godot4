extends Area2D

@onready var debug_logger : DebugLogger = get_tree().get_first_node_in_group("DEBUG_LOGGER")

@export var damage : int = 2
@export var repel_force := 100.0

func _on_body_entered(body: Node2D) -> void:
	if is_instance_of(body, CharacterBody2D):
		var direction = body.direction
		repel(body, direction)
		if body.name=="Player":
			debug_logger.add_log("Stake hit player: %s pts" %[damage])
			body.take_damage(damage)

func repel(body: CharacterBody2D, direction):
	body.velocity = Vector2.ZERO
	#body.velocity = Vector2(-direction * repel_force, repel_force)
