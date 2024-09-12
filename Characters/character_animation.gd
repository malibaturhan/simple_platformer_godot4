class_name CharacterAnimation
extends AnimatedSprite2D

@export var character : PlatformerCharacter

@export var state_machine: StateMachine

signal attack_completed
signal jump_completed
signal dead_signal
#
#func check_jump_finish():
	#if animation == "jump":
		#pass

func _physics_process(delta: float) -> void:
	if is_instance_valid(state_machine):
		if state_machine.active_state == StateMachine.States.IDLE:
			play("idle")
		if state_machine.active_state == StateMachine.States.WANDER:
			play("run")
		elif state_machine.active_state == StateMachine.States.ATTACK:
			play("attack1")
		if state_machine.active_state == StateMachine.States.START_JUMP:
			play("jump")
		if state_machine.active_state == StateMachine.States.DYING:
			play("dead")



func _on_animation_finished() -> void:
	if animation == "attack1":
		attack_completed.emit()
	if animation == "jump":
		jump_completed.emit()
	if animation == "dead":
		dead_signal.emit()
