class_name Interactable
extends Node

var is_interactable : bool = false

@onready var area_2d : Area2D
@export var interactable_body : PlatformerCharacter

func _ready() -> void:
	area_2d = find_area2d()
	# Create subscriptions for area2d
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	
func find_area2d() -> Area2D:
	return $Area2D if has_node("Area2D") else create_area2d()
	
func create_area2d() -> Area2D:
	var area = Area2D.new()
	
	var collision_shape = CollisionShape2D.new()
	
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(32, 64)
	
	collision_shape.shape = shape
	
	area.add_child(collision_shape)
	add_child(area)
	
	return area

func _on_body_entered(body):
	if is_instance_of(body, CharacterBody2D):
		interactable_body = body
		is_interactable = true
		print("body entered interaction area")
	
func _on_body_exited(body):
	if is_instance_of(body, CharacterBody2D):
		interactable_body = null
		is_interactable = false
		print("body entered interaction area")
	print("body exited interaction area")
