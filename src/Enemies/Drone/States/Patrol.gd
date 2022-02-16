extends State

func enter() -> void:
	player.direction = 1
	print('ffff')
	
func logic(delta) -> void:
	print('llll')
	detect_ledge()


func physics_logic(delta) -> void:
	player.velocity.x = player.direction * player.speed
	
	print('bbbbb')

func apply_gravity(delta) -> void:
	
	if !player.is_on_floor():
		player.velocity.y += player.gravity
	else:
		player.velocity.y = 1

	print('szszszs')
	
func detect_ledge() -> void:
	
	
	
	if player.ledgeDetector.is_colliding() == null:
		print("----------")
		change_direction()

func change_direction() -> void:
	player.direction = -player.direction
