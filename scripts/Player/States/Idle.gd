extends State

var idleAnimation : String = "idle"
 
func enter() -> void:
	host.animatedSprite.play(idleAnimation)
	
	
	host.velocity.x = host.direction * host.speed

func get_transition(delta):
	
	if Input.is_action_just_pressed("jump") and host.is_on_floor():
		return states.JUMP
	elif abs(host.direction) > 0:
		return states.RUN
	elif Input.is_action_just_pressed("shoot"):
		return states.SHOOT
	else:
		return null
	
