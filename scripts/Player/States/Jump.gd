extends Run

var jumpAnimation : String = "jump"

var jumpBufferTime = 0.95
var jumpBufferTimer

var isJumpBufferPressed = false


func enter() -> void:
	jumpBufferTimer = jumpBufferTime
	isJumpBufferPressed = false
	
	
	host.animatedSprite.play(jumpAnimation)
	host.velocity.y = -host.jumpSpeed

func logic(delta):
	jumpBufferTimer -= 1.0 * delta
	jumpBufferTimer = max(jumpBufferTimer, 0)
	
	if jumpBufferTimer == 0.0:
		if Input.is_action_just_pressed("jump"):
			isJumpBufferPressed = true
	
	
	
func get_transition(delta):
	
	var absHostDirection = abs(host.direction)
	
	
	if isJumpBufferPressed and host.is_on_floor():
		return states.JUMP
	
	
	
	if Input.is_action_just_pressed("shoot") and absHostDirection == 0:
		return states.SHOOT   
		
	elif Input.is_action_just_pressed("shoot") and absHostDirection > 0:
		return states.RUN_SHOOT
		
	elif host.is_on_floor() and absHostDirection > 0:
		return states.RUN
		
	elif host.is_on_floor() and absHostDirection == 0:
		return states.IDLE
	

