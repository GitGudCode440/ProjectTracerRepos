extends CanvasLayer

"""
	ScreenManager for dealing with UI and screens in Game
"""

onready var gameOverButton : Control = $Screens/GameOver/CenterContainer/VBoxContainer/Button
onready var levelCompButton : Control = $Screens/LevelCompleted/CenterContainer/VBoxContainer/Button

signal change_level
signal reload_level


func _ready() -> void:
	
	self.connect("change_level", get_parent(), "change_level")
	self.connect("reload_level", get_parent(), "reload_level")


func _on_game_over_Button_pressed():
	emit_signal("reload_level")


func _on_level_comp_Button_pressed():
	emit_signal("change_level")


func _on_AnimationPlayer_animation_started(anim_name):
	
	if anim_name == "RESET":
		get_tree().paused = false
	else:
		get_tree().paused = true
