extends Node

onready var states : Dictionary = {
	"PATROL" : $Patrol,
	"CHASE" : $Chase
}

var player : KinematicBody2D = get_parent()

var current_state : Node = null


func enter() -> void:
	
	
	pass

func logic(delta) -> void:
	pass

func physics_logic(delta) -> void:
	pass

func set_state() -> Node:
	return null
