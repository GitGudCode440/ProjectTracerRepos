extends Node

"""
	Game is a node with a script which adds child level acc to index from resources
	given in levelRef and adds ScreenManager for dealing with level UI
"""

var level
var children

var levelRef = []

var screenManager
var screenManagerPath = preload("res://scenes/ScreenManager.tscn")

var levelCounter = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _ready():
	levelRef = list_all_levels("res://scenes/levels")
	
	level = levelRef[levelCounter].instance()
	add_child(level)
	
	screenManager = screenManagerPath.instance()
	add_child(screenManager)
	
	

func change_level() -> void:
	
	levelCounter += 1
	
	if levelCounter > (levelRef.size() - 1):
		quit_game()
		return
	
	level.queue_free()
	
	level = levelRef[levelCounter].instance()
	
	
	
	add_child(level)
	
	get_tree().paused = false
	
	screenManager.get_node("AnimationPlayer").play("RESET")

func reload_level() -> void:
	level.queue_free()
	
	level = levelRef[levelCounter].instance()
	add_child(level)
	
	get_tree().paused = false
	screenManager.get_node("AnimationPlayer").play("RESET")
	

func list_all_levels(_path : String) -> Array:
	var files := []
	
	var dir := Directory.new()
	dir.open(_path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with('.'):
			var res = load(_path + "/" + file)
			files.append(res)
	
	dir.list_dir_end()
	
	return files
	

func show_game_over() -> void:
	screenManager.get_node("AnimationPlayer").play("on_game_over")


func show_level_comp() -> void:
	screenManager.get_node("AnimationPlayer").play("on_level_completed")

func quit_game() -> void: #Function for going out of Game into ending.
	pass
