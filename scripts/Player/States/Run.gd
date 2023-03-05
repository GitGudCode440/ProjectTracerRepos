extends State
class_name Run

var runAnimation : String = "run"

export(float) var coyoteTime : float = 2.0
var coyoteTimer : float = 1.0

func enter() -> void:
	host.animatedSprite.play(runAnimation)
	
func physics_logic(delta) -> void:
	host.velocity.x = lerp(host.velocity.x, host.direction * host.speed, host.deccelerationRate)
	
	
func logic(delta) -> void:
	
	
	if !host.is_on_floor():
		coyoteTimer -= 1.0 * delta
	else:
		coyoteTimer = coyoteTime
	
	if host.direction > 0:
		host.animatedSprite.flip_h = false
	elif host.direction < 0:
		host.animatedSprite.flip_h = true
	
	
func get_transition(delta):
	
	
	if Input.is_action_just_pressed("jump") and coyoteTimer > 0.0:
		return states.JUMP
		
	elif host.direction == 0:
		return states.IDLE
	
	elif Input.is_action_pressed("shoot"):
		return states.RUN_SHOOT
		
	else:
		return null
	
	
