extends State

"""
	The state for chasing the player for drone
"""

var player : KinematicBody2D

export(int) var chaseSpeed
export(float) var shootTime

var enemyBullet : Resource = preload("res://scenes/EnemyBullet.tscn")

var shootTimer : Timer = Timer.new()

var directionToPlayer : Vector2

func enter() -> void:
	
	#Redefining target as player for better readibility
	player = target
	
	add_child(shootTimer)
	
	shootTimer.connect("timeout", self, "on_ShootTimer_timeout")
	shootTimer.start(shootTime)
	
	host.fieldOfView.queue_free()
	host.ledgeDetector.queue_free()
	
	
	host.collision_layer = 8 #Setting collisiion layer to Ghost
	
	host.collision_mask = 1 #Setting collision maks to Player
	host.set_collision_mask_bit(3, true) #and itself(Ghost)
	

func logic(delta) -> void:
	
	# Assigning a vector which gives us direction and ditstance of the player,
	# in relation to itself.
	
	if (is_instance_valid(player)):
		host.distanceToPlayer = (player.global_position - host.global_position)
		directionToPlayer = host.distanceToPlayer.normalized()
		host.direction = directionToPlayer.x
	
	
func physics_logic(delta) -> void:
	
	chase()
	
func shoot() -> void:
	
	var instance = enemyBullet.instance()
	
	host.add_child(instance)
	instance.set_direction(directionToPlayer)
	
func chase() -> void:
	
	#If the drone is at a distance of more than 200 units, chase
	#Otherwise, slowly stop.
	 
	
	if host.distanceToPlayer.length() > 200:
		host.velocity = directionToPlayer * chaseSpeed
	else:
		host.velocity = lerp(host.velocity, Vector2.ZERO, 0.2)
	
	
func on_ShootTimer_timeout():
	
	shoot()
	shootTimer.start(shootTime)
	
