extends State

var directionToPlayer : Vector2 = Vector2.ZERO
var chaseSpeed : int = 300

func enter() -> void:
	
	drone.collider.queue_free()


func logic(delta) -> void:
	
	directionToPlayer = (player.global_position - drone.global_position)
	
	
func physics_logic(delta) -> void:
	
	if directionToPlayer.length() < 200:
		drone.velocity = lerp(drone.velocity, Vector2.ZERO, 0.05)
	else:
		drone.velocity = directionToPlayer.normalized() * chaseSpeed
	
	
	print(drone.global_position)
	
