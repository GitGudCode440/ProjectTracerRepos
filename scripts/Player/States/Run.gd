extends State
class_name Run

var runAnimation : String = "run"

func enter() -> void:
	host.animatedSprite.play(runAnimation)
	
func physics_logic(delta) -> void:
	host.velocity.x = host.direction * host.speed
	
func logic(delta) -> void:
	
	if host.direction > 0:
		host.animatedSprite.flip_h = false
	elif host.direction < 0:
		host.animatedSprite.flip_h = true
	

func get_transition(delta):
	
	if Input.is_action_just_pressed("jump") and host.is_on_floor():
		return states.JUMP
	elif host.direction == 0:
		return states.IDLE
	elif Input.is_action_pressed("shoot"):
		return states.SHOOT
	else:
		return null
