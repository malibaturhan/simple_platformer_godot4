extends Node2D

@export var character : PlatformerCharacter:
	set(value):
		if is_instance_valid(character):		# Checks if that instance is located on RAM - is it exist
			character.direction_changed.disconnect(change_orientation)
		character = value
		if is_instance_valid(character):
			character.direction_changed.connect(change_orientation)
		else:
			return
	get:
		return character
		
func change_orientation(direction: float):
	if direction == 0:
		return
	scale.x = 1 * sign(direction)
	
