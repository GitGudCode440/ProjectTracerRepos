extends State

func enter() -> void:
	drone.direction = 1
	
func logic(delta) -> void:
	detect_ledge()


func physics_logic(delta) -> void:
	drone.velocity.x = drone.direction * drone.speed
	

func on_collisions(delta) -> void:
	
	apply_gravity()
	
func detect_ledge() -> void:
	
	
	
	if !drone.ledgeDetector.is_colliding() and drone.is_on_floor():
		change_direction()

func change_direction() -> void:
	drone.direction = -drone.direction
	drone.ledgeDetector.position.x = drone.ledgeOffset * drone.direction

func apply_gravity() -> void:
	
	if !drone.is_on_floor():
		drone.velocity.y += drone.gravity
	else:
		drone.velocity.y = 1

func get_transition() -> Node:
	
	#Checks if the drone has detected a player.
	#If so, transition to 'Chase' state
	
	return null
