extends State

func enter() -> void:
	player.direction = 1

func physics_logic(delta) -> void:
	player.velocity.x = player.direction * player.speed


