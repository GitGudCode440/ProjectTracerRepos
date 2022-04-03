extends Node
class_name StateMachine

"""
	This is the state manager or machine which delegates processes and info
	to children states according to a given transition retruned by the states.
"""

export (Dictionary) onready var states


export (NodePath) var firstState
var previousState : NodePath

var currentState : Node


func enter(_host : KinematicBody2D,
			_target : KinematicBody2D) -> void:
	
	
	previousState = firstState
	currentState = get_node(firstState)
	
	for child in get_children():
		child.target = _target
		child.host = _host
		
		child.states = self.states
		child.previousState = self.previousState
		
	
	
	currentState.enter()
	
	pass

func logic(delta) -> void:
	currentState.logic(delta)
	set_state(delta)

func physics_logic(delta) -> void:
	currentState.physics_logic(delta)
	
	
func on_collisions(delta) -> void:
	currentState.on_collisions(delta)

	
func set_state(delta) -> void:
	
	var transition : NodePath
	
	
	if !currentState.get_transition(delta):
		return
	else:
		transition  = currentState.get_transition(delta)
		
		previousState = get_path_to(currentState)
		
		currentState = get_node(transition)
		currentState.enter()
		
	
	
	
	 
