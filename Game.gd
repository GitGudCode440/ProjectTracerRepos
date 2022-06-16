extends Node

"""
	Game is a node with a script which adds child level acc to index from resources
	given in levelPath and adds ScreenManager for dealing with level UI
"""

var level
var children

var levelPath = [
	preload("res://scenes/levels/Level1.tscn")
]

var screenManager
var screenManagerPath = preload("res://scenes/ScreenManager.tscn")

var levelCounter = 0

func _ready():
	level = levelPath[levelCounter].instance()
	add_child(level)
	
	screenManager = screenManagerPath.instance()
	add_child(screenManager)
	
	

func change_level() -> void:
	
	levelCounter += 1
	
	if levelCounter > levelPath.size():
		return
	
	level.queue_free()
	
	level = levelPath[levelCounter].instance()
	
	
	
	add_child(level)
	
	get_tree().paused = false
	
	screenManager.get_node("AnimationPlayer").play("RESET")

func reload_level() -> void:
	level.queue_free()
	
	level = levelPath[levelCounter].instance()
	add_child(level)
	
func show_game_over() -> void:
	screenManager.get_node("AnimationPlayer").play("on_game_over")


func show_level_comp() -> void:
	screenManager.get_node("AnimationPlayer").play("on_level_completed")

