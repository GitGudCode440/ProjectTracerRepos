extends Node

onready var states : Dictionary = {
	"PATROL" : $Patrol,
	"CHASE" : $Chase
}

var player : KinematicBody2D = get_parent()

var current_state : Node = null


func enter() -> void:
	current_state = states.PATROL
	
	for child in get_children():
		child.stateMachine = self
		child.player = player
	
	current_state.enter()
	
	pass

func logic(delta) -> void:
	current_state.logic(delta)

func physics_logic(delta) -> void:
	current_state.logic(delta)
	
	
func set_state() -> Node:
	return null
