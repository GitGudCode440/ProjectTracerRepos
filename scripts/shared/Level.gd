extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var playerCamera : Camera2D = $PlayerCamera
@export var cameraOffset : int

@onready var carRed : Area2D = $CarRed

@onready var drones : Node = $Drones
@onready var turrets : Node = $Turrets


signal show_game_over
signal show_level_comp

func _ready() -> void:
	self.connect("show_game_over", Callable(get_parent(), "show_game_over"))
	self.connect("show_level_comp", Callable(get_parent(), "show_level_comp"))
	
	pass

func _process(delta):
	if (is_instance_valid(player)):
		playerCamera.global_position = player.global_position
		playerCamera.global_position.x += cameraOffset #Offseting the camera here because of some bug I can't seem to fix
	
	
func _on_CarRed_body_entered(body) -> void:
	emit_signal("show_level_comp")
	
	self.disconnect("show_level_comp", Callable(get_parent(), "show_level_comp"))

	
