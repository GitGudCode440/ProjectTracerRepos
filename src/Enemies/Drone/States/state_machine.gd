extends Node

onready var states : Dictionary = {
	"PATROL" : $Patrol,
	"CHASE" : $Chase
}

onready var player : KinematicBody2D 

var current_state : Node = null


func enter(_player) -> void:
	player = _player
	current_state = states.PATROL
	
	for child in get_children():
		child.player = player
	
	current_state.enter()
	
	pass

func logic(delta) -> void:
	current_state.logic(delta)

func physics_logic(delta) -> void:
	current_state.physics_logic(delta)
	
	
func on_collisions(delta) -> void:
	current_state.on_collisions(delta)

	
func set_state() -> void:
	
	var transition : Node = current_state.get_transition()
	
	if transition != null:
		current_state = transition
		current_state.enter()
