extends Node

onready var states : Dictionary = {
	"PATROL" : $Patrol,
	"CHASE" : $Chase
}

var player : KinematicBody2D = get_parent()




func enter() -> void:
	pass

func logic() -> void:
	pass

func physics_logic() -> void:
	pass

func set_state() -> Node:
	return null
