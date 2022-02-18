extends Node
class_name State

var drone : KinematicBody2D = null
var player : KinematicBody2D = null

var states : Dictionary = {}

func enter() -> void:
	pass

func logic(delta) -> void:
	pass

func physics_logic(delta) -> void:
	pass

func on_collisions(delta) -> void:
	pass


func get_transition() -> Node:
	return null 
