extends State

var jumpAnimation : String = "jump"
var jumpTimer : Timer = Timer.new()


func enter() -> void:
	animation = jumpAnimation
	.enter()
	
	
	host.velocity.y = -host.jumpSpeed

func logic(delta) -> void:
	
	if host.direction > 0: 
		animatedSprite.flip_h = false
	elif host.direction <  0:
		animatedSprite.flip_h = true


func physics_logic(delta) -> void:
	
	host.velocity.x = host.direction * host.speed
	

func get_transition(delta):
	
	if host.is_on_floor() and abs(host.direction) > 0:
		return states.RUN
	elif host.is_on_floor() and host.direction == 0:
		return states.IDLE
