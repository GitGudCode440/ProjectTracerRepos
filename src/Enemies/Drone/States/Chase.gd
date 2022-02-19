extends State

var directionToPlayer : Vector2 = Vector2.ZERO
var chaseSpeed : int = 300
var enemyLaser : Resource = preload("res://src/Bullet/EnemyBullet/EnemyBullet.tscn")

func enter() -> void:
	
	
	drone.ledgeDetector.queue_free()
	drone.fieldOfView.queue_free()
	
	drone.collider.queue_free()


func logic(delta) -> void:
	
	# Assigning a vector which gives us direction and ditstance of the player,
	# in relation to itself.
	directionToPlayer = (player.global_position - drone.global_position)
	
	shoot()
	
func physics_logic(delta) -> void:
	
	chase()
	
func shoot() -> void:
	
	var instance = enemyLaser.instance()
	
	drone.add_child(instance)
	instance.set_direction(directionToPlayer.normalized())
	
func chase() -> void:
	
	
	if directionToPlayer.length() < 200:
		drone.velocity = lerp(drone.velocity, Vector2.ZERO, 0.05)
	else:
		drone.velocity = directionToPlayer.normalized() * chaseSpeed
	
	
	
	
