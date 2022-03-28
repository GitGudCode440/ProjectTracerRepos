extends Run

var jumpAnimation : String = "jump"


func enter() -> void:
	host.animatedSprite.play(jumpAnimation)
	
	
	host.velocity.y = -host.jumpSpeed


func get_transition(delta):
	
	if host.is_on_floor() and abs(host.direction) > 0:
		return states.RUN
	elif host.is_on_floor() and host.direction == 0:
		return states.IDLE
