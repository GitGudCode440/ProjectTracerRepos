extends Node

var cameraShakeDuration : float = 0.0
var cameraShakeIntensity : float = 0.0

var offset : Vector2 = Vector2.ZERO

onready var camera : Camera2D = get_tree().get_root().find_node("PlayerCamera", true, false)




func shake(_duration : float = 0.0, _intensity : float = 0.0):
	cameraShakeDuration = _duration
	cameraShakeIntensity = _intensity
	
	
func _process(delta):
	
	cameraShakeDuration = clamp(cameraShakeDuration - delta, 0, INF)
	
	if !is_instance_valid(camera):
		camera = get_tree().get_root().find_node("PlayerCamera", true, false)
		return
	
	
	if cameraShakeDuration != 0:
		randomize()
		offset = Vector2(randf() * cameraShakeIntensity, randf() * cameraShakeIntensity)
		
		
		camera.offset = offset
		
	else:
		randomize()
		offset = Vector2(randf() * cameraShakeIntensity, randf() * cameraShakeIntensity)
		camera.offset = offset
		cameraShakeIntensity = lerp(cameraShakeIntensity, 0, 0.25)
	
	
