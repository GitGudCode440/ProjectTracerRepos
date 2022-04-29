extends Node

"""
	Game is a node with a script which adds child level acc to index from resources given
	in levelPath
"""

var level

var levelPath = [
	preload("res://scenes/levels/LevelTemplate.tscn"),
	preload("res://scenes/levels/Level1.tscn")
]

var levelCounter = 0

func _ready():
	level = levelPath[levelCounter].instance()
	add_child(level)
	

func change_level() -> void:
	levelCounter += 1
	level = levelPath[levelCounter].instance()
	get_child(0).queue_free()
	add_child(level)

func reload_level() -> void:
	
	get_child(0).queue_free()
	level = levelPath[levelCounter].instance()
	add_child(level)
	
