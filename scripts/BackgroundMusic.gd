extends AudioStreamPlayer

func _ready():
	
	yield(get_tree(), "idle_frame")
	
	play()
