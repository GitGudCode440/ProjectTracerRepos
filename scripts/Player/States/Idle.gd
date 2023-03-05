extends State

var idleAnimation : String = "idle"
 
func enter() -> void:
	host.animatedSprite.play(idleAnimation)
	

func physics_logic(delta) -> void:
	host.velocity.x = lerp(host.velocity.x, 0.0, host.accelerationRate)

func get_transition(delta):
	
	if Input.is_action_just_pressed("jump") and host.is_on_floor():
		return states.JUMP
	elif abs(host.direction) > 0:
		return states.RUN
	elif Input.is_action_just_pressed("shoot"):
		return states.SHOOT
	else:
		return null
	
