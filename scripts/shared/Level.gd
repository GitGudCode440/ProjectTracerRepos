extends Node2D

onready var player : KinematicBody2D = $Player

onready var carRed : Area2D = $CarRed

onready var animationPlayer : AnimationPlayer = $AnimationPlayer


signal show_game_over
signal show_level_comp

func _ready() -> void:
	self.connect("show_game_over", get_parent(), "show_game_over")
	self.connect("show_level_comp", get_parent(), "show_level_comp")
	
	pass

func _process(delta) -> void:
	pass
	
	
	
func _on_CarRed_body_entered(body) -> void:
	emit_signal("show_level_comp")
	
	self.disconnect("show_level_comp", get_parent(), "show_level_comp")

	
