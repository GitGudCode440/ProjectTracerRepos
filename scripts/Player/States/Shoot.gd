extends State

var shootAnimation : String = "shoot"

var bulletInstance : Area2D

func enter() -> void:
	
	host.animatedSprite.play(shootAnimation)
	
	shoot()
	
	
	
func get_transition(delta):
	
	if !Input.is_action_pressed("shoot"):
		return previousState
		
	


func shoot() -> void:
	
	bulletInstance = host.bullet.instance()
	host.add_child(bulletInstance)
	
	var direction : Vector2 = host.bulletDirection.normalized()
	bulletInstance.set_direction(direction)
	
