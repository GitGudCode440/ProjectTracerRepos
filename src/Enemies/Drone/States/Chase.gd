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
	
	yield(get_tree(), "idle_frame")
	shoot()
	
	drone.ledgeDetector.queue_free()
	drone.fieldOfView.queue_free()
	
	drone.collider.queue_free()


func logic(delta) -> void:
	
	# Assigning a vector which gives us direction and ditstance of the player,
	# in relation to itself.
	directionToPlayer = (player.global_position - drone.global_position)
	
	
	
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
	
	
func on_ShootTimer_timeout():
	
	shoot()
	shootTimer.start(shootTime)
	
