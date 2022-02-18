extends State

func logic(delta) -> void:
	
	var directionToPlayer : Vector2 = (player.position - drone.position).normalized()  
	
	
