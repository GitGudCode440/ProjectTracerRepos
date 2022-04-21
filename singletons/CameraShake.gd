extends Node

var cameraShakeDuration : float = 0.0
var cameraShakeIntensity : float = 0.0

var offset : Vector2 = Vector2.ZERO

onready var camera : Camera2D = get_tree().get_root().find_node("Camera2D", true, false)




func shake(_duration : float = 0.0, _intensity : float = 0.0):
	cameraShakeDuration = _duration
	cameraShakeIntensity = _intensity
	
	
func _process(delta):
	
	cameraShakeDuration = clamp(cameraShakeDuration - delta, 0, INF)
	
	if !is_instance_valid(camera):
		camera = get_tree().get_root().find_node("Camera2D", true, false)
	
	
	if cameraShakeDuration != 0:
		offset = Vector2(randf() * cameraShakeIntensity, randf() * cameraShakeIntensity)
		
		
		camera.offset = offset
		
	else:
		offset = Vector2.ZERO
		camera.offset = offset
		cameraShakeIntensity = 0
	
