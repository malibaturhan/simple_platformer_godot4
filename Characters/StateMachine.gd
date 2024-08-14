class_name StateMachine
extends Node

enum States {
	IDLE,
	WANDER,
	CHASE,
	JUMP,
	ATTACK
}

var ground_states : Array = [States.IDLE, States.WANDER, States.ATTACK]

@export var character: PlatformerCharacter

var active_state: States

func _ready() -> void:
	enter_state(States.IDLE)
	character.state_change.connect(enter_state)
	
func enter_state(new_state: States):
	active_state = new_state
	print("entered %s state" %[States.keys()[active_state]])

