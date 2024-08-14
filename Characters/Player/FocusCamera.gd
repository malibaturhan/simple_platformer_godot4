extends Camera2D

@export var focus_target: PlatformerCharacter

@export var min_distance : float = 4.0
@export var max_distance : float = 6.0
@export var camera_speed : float = 9.0

var focus_distance : float = 0

var characters		: Array[PlatformerCharacter]
var active_target_index : int = 0

func _ready() -> void:
	focus_distance = abs(global_transform.origin - focus_target.global_position).length()
	subscribe_direction()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_camera_debug"):
		focus_target = characters[(active_target_index + 1) % len(characters)]
		active_target_index += 1
	
func _physics_process(delta: float) -> void:
	if focus_distance < min_distance:
		return
	elif focus_distance > max_distance:
		global_position = lerp(global_position, global_position + (focus_target.global_position - global_position), delta * camera_speed)

func subscribe_direction():
	if is_instance_valid(focus_target):
		pass
		

func add_platformer_character_to_camera_list(character: PlatformerCharacter):
	characters.append(character)
	print("%s is added into camera character list" % [character.name])
