extends Node
class_name StateMachine

"""
	This is the state manager or machine which delegates processes and info
	to children states according to a given transition retruned by the states.
"""

export (Dictionary) onready var states

onready var host : KinematicBody2D = null

#A kinematic body entity which can be interacted to perform some logic 
onready var target : KinematicBody2D = null 


var current_state : Node = null


func enter(_host, _target) -> void:
	
	set_states()
	
	host = _host
	target = _target
	
	
	
	for child in get_children():
		child.target = self.target
		child.host = self.host
		child.states = self.states
	
	current_state.enter()
	
	pass

func logic(delta) -> void:
	current_state.logic(delta)
	set_state(delta)

func physics_logic(delta) -> void:
	current_state.physics_logic(delta)
	
	
func on_collisions(delta) -> void:
	current_state.on_collisions(delta)

	
func set_state(delta) -> void:
	
	var transition : Node = current_state.get_transition(delta)
	
	if transition != null:
		current_state = transition
		current_state.enter()

func set_states() -> void:
	pass
