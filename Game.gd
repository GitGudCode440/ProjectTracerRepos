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

var scoreOnLevelLoad := 0
var scoreText

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _ready():
	levelRef = list_all_levels("res://scenes/levels")
	
	level = levelRef[levelCounter].instantiate()
	#print(level)
	add_child(level)
	
	screenManager = screenManagerPath.instantiate()
	add_child(screenManager)
	
	scoreText = screenManager.scoreText
	
	

func change_level() -> void:
	
	levelCounter += 1
	
	if levelCounter > (levelRef.size() - 1):
		quit_game()
		return
	
	level.queue_free()
	
	level = levelRef[levelCounter].instantiate()
	
	
	
	add_child(level)
	
	get_tree().paused = false
	
	scoreOnLevelLoad = scoreText.score
	
	screenManager.animationPlayer.play("RESET")
	screenManager.healthBar.reset_health()
	
	

func reload_level() -> void:
	level.queue_free()
	
	level = levelRef[levelCounter].instantiate()
	add_child(level)
	
	get_tree().paused = false
	
	scoreText.set_score(scoreOnLevelLoad)
	
	
	
	screenManager.animationPlayer.play("RESET")
	screenManager.healthBar.reset_health()
	

func list_all_levels(_path : String) -> Array:
	var files := []
	
	var dir := DirAccess.open(_path)

	var allFiles = dir.get_files()
	
	for i in allFiles:
		if i.ends_with(".tscn"):
			var level = load(_path + "/" + i)
			files.push_back(level)
		
	
	
	return files
	

func show_game_over() -> void:
	screenManager.animationPlayer.play("on_game_over")
	


func show_level_comp() -> void:
	screenManager.animationPlayer.play("on_level_completed")
	
func quit_game() -> void: #Function for going out of Game into ending.
	pass
