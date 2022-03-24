extends State

var runAnimation : String = "run"

func enter() -> void:
	animation = runAnimation
	.enter()
	
	if host.direction > 0:
		animatedSprite.flip_h = false
	else:
		animatedSprite.flip_h = true
	
func physics_logic(delta):
	host.velocity.x = host.direction * host.speed
	

func get_transition(delta):
	
	if host.direction == 0:
		return states.IDLE
	else:
		return null
