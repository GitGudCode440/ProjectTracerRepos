extends Node2D

onready var player : KinematicBody2D = $Player
onready var playerCamera : Camera2D = $PlayerCamera
onready var carRed : Area2D = $CarRed

onready var drones : Node = $Drones
onready var turrets : Node = $Turrets


signal show_game_over
signal show_level_comp

func _ready() -> void:
	self.connect("show_game_over", get_parent(), "show_game_over")
	self.connect("show_level_comp", get_parent(), "show_level_comp")
	
	pass

func _process(delta):
	playerCamera.global_position = player.global_position
	
	
func _on_CarRed_body_entered(body) -> void:
	emit_signal("show_level_comp")
	
	self.disconnect("show_level_comp", get_parent(), "show_level_comp")

	
