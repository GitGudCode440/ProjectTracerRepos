extends Run

var jumpAnimation : String = "jump"


func enter() -> void:
	host.animatedSprite.play(jumpAnimation)
	
	
	host.velocity.y = -host.jumpSpeed


func get_transition(delta):
	
	var absHostDirection = abs(host.direction)
	
	if Input.is_action_just_pressed("shoot") and absHostDirection == 0:
		return states.SHOOT   
		
	elif Input.is_action_just_pressed("shoot") and absHostDirection > 0:
		return states.RUN_SHOOT
		
	elif host.is_on_floor() and absHostDirection > 0:
		return states.RUN
		
	elif host.is_on_floor() and absHostDirection == 0:
		return states.IDLE
		
	else:
		return null
