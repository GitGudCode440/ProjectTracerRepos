extends Node
class_name StateMachine

"""
	This is the state manager or machine which delegates processes and info
	to children states according to a given transition retruned by the states.
"""

export (Dictionary) onready var states


export (NodePath) var first_state
var current_state : Node 


func enter(_host : KinematicBody2D,
			_target : KinematicBody2D,
			_animatedSprite : AnimatedSprite) -> void:
	
	
	
	current_state = get_node(first_state)
	
	for child in get_children():
		child.target = _target
		child.host = _host
		child.animatedSprite = _animatedSprite
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
	
	var transition : NodePath
	
	if !current_state.get_transition(delta):
		return
	else:
		transition  = current_state.get_transition(delta)
	
	if transition != null:
		current_state = get_node(transition)
		current_state.enter()
	
	
	
	
	 
