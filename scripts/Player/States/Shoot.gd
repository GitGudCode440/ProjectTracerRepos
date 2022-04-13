extends State
class_name Shoot

var shootAnimation : String = "shoot"

export(float) onready var timeLeft
var timeSpecified : float

var bulletInstance : Area2D

func enter() -> void:
	timeLeft = timeSpecified
	
	host.animatedSprite.play(shootAnimation)
	
	shoot()
	
	animate()
	
	
func logic(delta) -> void:
	
	timeLeft = clamp(timeLeft - delta, 0, INF)
	
	
func get_transition(delta):
	
	if !Input.is_action_pressed("shoot") and timeLeft == 0:
		return previousState
	else:
		return null
	


func shoot() -> void:
	
	bulletInstance = host.bullet.instance()
	host.add_child(bulletInstance)
	
	var direction : Vector2 = host.bulletDirection.normalized()
	bulletInstance.set_direction(direction)
	
	host.direction = direction.x

func animate() -> void:
	
	if host.direction > 0:
		host.animatedSprite.flip_h = false
		
	elif host.direction < 0:
		host.animatedSprite.flip_h = true
		
 
