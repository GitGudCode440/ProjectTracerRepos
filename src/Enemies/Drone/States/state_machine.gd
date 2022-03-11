extends Node

"""
	This is the state manager or machine which delegates processes and info
	to children states according to a given transition retruned by the states.
"""

onready var states : Dictionary = {
	"PATROL" : $Patrol,
	"CHASE" : $Chase
}

onready var host : KinematicBody2D = null
onready var player : KinematicBody2D = null

var current_state : Node = null


func enter(_host, _player) -> void:
	host = _host
	player = _player
	
	
	current_state = states.PATROL
	
	for child in get_children():
		child.player = self.player
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
