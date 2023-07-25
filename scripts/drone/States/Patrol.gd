extends State

"""
	The state for patrolling the environment for drone
"""

export(bool) var detectLedge = true
export(bool) var initialTravelLeft = false

#Redefining target as player for better readibility

func enter() -> void:
	var direction : float
	
	if initialTravelLeft:
		change_direction()
		align_ray_to_direction()
	

	
func logic(delta) -> void:
	detect_ledge()

	if host.distanceToPlayer.length() < host.detectionRange:
		host.fieldOfView.enabled = true
	else:
		host.fieldOfView.enabled = false
	
func physics_logic(delta) -> void:
	host.velocity.x = host.direction * host.speed
	

func on_collisions(delta) -> void:
	
	apply_gravity()
	
	if host.is_on_wall():
		change_direction()
		align_ray_to_direction()
	
func detect_ledge() -> void:
	#Changes the direction, if the drone is on a ledge
	
	
	if !host.ledgeDetector.is_colliding() && host.is_on_floor() && detectLedge:
		change_direction() 


func change_direction() -> void:
	
	
	host.direction = -host.direction
	


func align_ray_to_direction() -> void: #Orients the rays according to the direction.
	
	host.ledgeDetector.position.x = host.ledgeOffset * host.direction
	host.fieldOfView.cast_to.x = host.fovCast * host.direction

func apply_gravity() -> void:
	
	#Applies graviity to drone if not is on floor
	
	if !host.is_on_floor():
		host.velocity.y += host.gravity
	else:
		host.velocity.y = 1

func get_transition(delta):
	
	#Checks if the drone has detected Player.
	#If so, transition to 'Chase' state.
	
	if host.fieldOfView.get_collider() == target: #Target is player in this context
		return states.CHASE
	else:
		return null
