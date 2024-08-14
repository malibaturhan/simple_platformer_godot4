class_name CharacterAnimation
extends AnimatedSprite2D

@export var character : PlatformerCharacter

@export var state_machine: StateMachine

signal attack_completed


func check_attack_finish():
	if animation == "attack1":
		pass

func check_jump_finish():
	if animation == "jump":
		pass

func _physics_process(delta: float) -> void:
	check_attack_finish()
	if is_instance_valid(state_machine):
		if state_machine.active_state == StateMachine.States.IDLE:
			play("idle")
		elif state_machine.active_state == StateMachine.States.WANDER:
			play("run")
		elif state_machine.active_state == StateMachine.States.ATTACK:
			play("attack1")
			print("attack1 animation plays")
		if state_machine.active_state == StateMachine.States.JUMP:
			play("jump")

