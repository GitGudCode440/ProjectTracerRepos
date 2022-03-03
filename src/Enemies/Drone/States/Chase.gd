extends State

export(int) var chaseSpeed
export(float)var shootTime

var enemyBullet : Resource = preload("res://src/Bullet/EnemyBullet/EnemyBullet.tscn")

var shootTimer : Timer = Timer.new()

var distanceToPlayer : Vector2 
var directionToPlayer : Vector2

func enter() -> void:
	
	
	add_child(shootTimer)
	
	shootTimer.connect("timeout", self, "on_ShootTimer_timeout")
	shootTimer.start(shootTime)
	
	
	host.ledgeDetector.queue_free()
	host.fieldOfView.queue_free()
	
	host.collider.queue_free()

func logic(delta) -> void:
	
	# Assigning a vector which gives us direction and ditstance of the player,
	# in relation to itself.
	
	distanceToPlayer = (player.global_position - host.global_position)
	directionToPlayer = distanceToPlayer.normalized()
	
	
func physics_logic(delta) -> void:
	
	chase()
	
func shoot() -> void:
	
	var instance = enemyBullet.instance()
	
	host.add_child(instance)
	instance.set_direction(directionToPlayer)
	
func chase() -> void:
	
	#If the drone is at a distance of more than 300 units, chase
	#Otherwise, slowly stop.
	
	if distanceToPlayer.length() > 300:
		host.velocity = directionToPlayer * chaseSpeed
	else:
		host.velocity = lerp(host.velocity, Vector2.ZERO, 0.2)
	
	
func on_ShootTimer_timeout():
	
	shoot()
	shootTimer.start(shootTime)
	
