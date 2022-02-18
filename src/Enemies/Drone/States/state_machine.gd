extends Node

onready var states : Dictionary = {
	"PATROL" : $Patrol,
	"CHASE" : $Chase
}

onready var drone : KinematicBody2D = null
onready var player : KinematicBody2D = null

var current_state : Node = null


func enter(_drone, _player) -> void:
	drone = _drone
	player = _drone
	
	current_state = states.PATROL
	
	for child in get_children():
		child.drone = self.drone
		child.player = self.player
		
		child.states = self.states
	
	current_state.enter()
	
	pass

func logic(delta) -> void:
	current_state.logic(delta)
	set_state()

func physics_logic(delta) -> void:
	current_state.physics_logic(delta)
	
	
func on_collisions(delta) -> void:
	current_state.on_collisions(delta)

	
func set_state() -> void:
	
	var transition : Node = current_state.get_transition()
	
	if transition != null:
		current_state = transition
		current_state.enter()
