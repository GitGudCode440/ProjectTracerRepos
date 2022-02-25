extends State

var directionToPlayer : Vector2 = Vector2.ZERO
export(int) var chaseSpeed

var enemyBullet : Resource = preload("res://src/Bullet/EnemyBullet/EnemyBullet.tscn")

var shootTimer : Timer = Timer.new()
var shootTime : float = 0.5

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
	
	directionToPlayer = (player.global_position - host.global_position)
	
	
func physics_logic(delta) -> void:
	
	chase()
	
func shoot() -> void:
	
	var instance = enemyBullet.instance()
	
	host.add_child(instance)
	instance.set_direction(directionToPlayer.normalized())
	
func chase() -> void:
	
	#If the drone is at a distance of more than 300 units, chase
	#Otherwise, slowly stop.
	
	if directionToPlayer.length() > 300:
		host.velocity = directionToPlayer.normalized() * chaseSpeed
	else:
		host.velocity = lerp(host.velocity, Vector2.ZERO, 0.2)
	
	
func on_ShootTimer_timeout():
	
	shoot()
	shootTimer.start(shootTime)
	
