extends CanvasLayer

"""
	ScreenManager for dealing with UI and screens in Game
"""

@onready var gameOverButton : Button = $Screens/GameOver/VBoxContainer/Button
@onready var levelCompButton : Button = $Screens/LevelCompleted/VBoxContainer/Button

@onready var healthBar := $GUI/MarginContainer/VBoxContainer/HealthBar

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

@onready var scoreText := $GUI/MarginContainer/ScoreText

signal change_level
signal reload_level


func _ready() -> void:
	
	
	self.connect("change_level", Callable(get_parent(), "change_level"))
	self.connect("reload_level", Callable(get_parent(), "reload_level"))


func _on_game_over_Button_pressed():
	emit_signal("reload_level")
	


func _on_level_comp_Button_pressed():
	emit_signal("change_level")


func _on_AnimationPlayer_animation_started(anim_name):
	
	if anim_name == "RESET":
		get_tree().paused = false
	else:
		get_tree().paused = true
