extends State

var idleAnimation : String = "idle"
 
func enter() -> void:
	animation = idleAnimation
	.enter()
	
	if host.direction > 0:
		pass
	
	
	host.velocity.x = host.direction * host.speed

func get_transition(delta):
	
	if abs(host.direction) > 0:
		return states.RUN
	else:
		return null
	
