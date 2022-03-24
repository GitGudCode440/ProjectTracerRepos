extends Node
class_name State

var host : KinematicBody2D = null
var target : KinematicBody2D = null

var animatedSprite : AnimatedSprite = null
var animation : String


var states : Dictionary = {}

func enter() -> void:
	animatedSprite.play(animation)

func logic(delta) -> void:
	pass

func physics_logic(delta) -> void:
	pass

func on_collisions(delta) -> void:
	pass

func get_transition(delta):
	return null
