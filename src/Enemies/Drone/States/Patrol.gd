extends State

func enter() -> void:
	player.direction = 1
	
func logic(delta) -> void:
	detect_ledge()


func physics_logic(delta) -> void:
	player.velocity.x = player.direction * player.speed
	

func on_collisions(delta) -> void:
	
	if !player.is_on_floor():
		player.velocity.y += player.gravity
	else:
		player.velocity.y = 1

	
func detect_ledge() -> void:
	
	
	
	if !player.ledgeDetector.is_colliding() and player.is_on_floor():
		change_direction()

func change_direction() -> void:
	player.direction = -player.direction
	player.ledgeDetector.position.x = player.ledgeOffset * player.direction
