extends Node
class_name State

var host : CharacterBody2D = null
var target : CharacterBody2D = null

var animation : String

var states : Dictionary = {}
var previousState : NodePath

func enter() -> void:
	pass

func logic(delta) -> void:
	pass

func physics_logic(delta) -> void:
	pass

func on_collisions(delta) -> void:
	pass

func get_transition(delta):
	return null
