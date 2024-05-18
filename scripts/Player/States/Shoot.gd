extends State
class_name Shoot

var shootAnimation : String = "shoot"

@export var timeLeft: float 
var timeSpecified : float

var bulletInstance : Area2D

func enter() -> void:
	timeLeft = timeSpecified
	
	host.animatedSprite.play(shootAnimation)
	
	
	shoot()
	CameraShake.shake(0.1, 5)
	
	animate()
	
	
func logic(delta) -> void:
	
	timeLeft = max(0, timeLeft - delta)
	
	
func get_transition(delta):
	
	if !Input.is_action_pressed("shoot") and timeLeft == 0:
		return previousState
	else:
		return null
	

func shoot() -> void:
	
	bulletInstance = host.bullet.instantiate()
	host.add_child(bulletInstance)
	
	var direction : Vector2 = host.bulletDirection.normalized()
	bulletInstance.set_direction(direction)
	
	host.direction = direction.x

func animate() -> void:
	
	if host.direction > 0:
		host.animatedSprite.flip_h = false
		
	elif host.direction < 0:
		host.animatedSprite.flip_h = true
		
 
