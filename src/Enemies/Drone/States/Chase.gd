extends State

var directionToPlayer : Vector2 = Vector2.ZERO
export(int) var chaseSpeed
var shootTimer : Timer = Timer.new()

var enemyBullet : Resource = preload("res://src/Bullet/EnemyBullet/EnemyBullet.tscn")


func enter() -> void:
	
	add_child(shootTimer)
	
	
	
	drone.ledgeDetector.queue_free()
	drone.fieldOfView.queue_free()
	
	drone.collider.queue_free()


func logic(delta) -> void:
	
	# Assigning a vector which gives us direction and ditstance of the player,
	# in relation to itself.
	directionToPlayer = (player.global_position - drone.global_position)
	
	
	
	if shootTimer.is_stopped():
		shootTimer.wait_time = 3.0
		shootTimer.start()
		shoot()
	
func physics_logic(delta) -> void:
	
	chase()
	
func shoot() -> void:
	
	var instance = enemyBullet.instance()
	
	drone.add_child(instance)
	instance.set_direction(directionToPlayer.normalized())
	
func chase() -> void:
	
	#If the drone is at a distance of more than 300 units, chase
	#Otherwise, slowly stop.
	
	if directionToPlayer.length() > 300:
		drone.velocity = directionToPlayer.normalized() * chaseSpeed
	else:
		drone.velocity = lerp(drone.velocity, Vector2.ZERO, 0.2)
	
	
	
	
