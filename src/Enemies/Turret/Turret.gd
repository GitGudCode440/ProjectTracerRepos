extends StaticBody2D

export(int) var detectionRange 

enum states {IDLE, SHOOT}
var currentState : int 

onready var lineOfSight : RayCast2D = $LineOfSight

onready var enemyLaser : Resource = preload("res://src/Bullet/EnemyBullet/EnemyBullet.tscn")

onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)
var distanceToPlayer : Vector2 
var directionToPlayer : Vector2

var shootTimer : Timer = Timer.new()
var shootTime : float = 0.35

func _ready():
	currentState = states.IDLE
	
	add_child(shootTimer)
	
	shootTimer.connect("timeout", self, "on_ShootTimer_timeout")
	shootTimer.start(shootTime)
	
	
func _process(delta):
	
	distanceToPlayer = (player.global_position - global_position)
	directionToPlayer = distanceToPlayer.normalized()
	
	
	var angleOfRotation = directionToPlayer.angle_to(Vector2.DOWN)
	lineOfSight.rotation = -angleOfRotation
	
	
	if distanceToPlayer.length() < detectionRange:
		lineOfSight.enabled = true
		
		
		if lineOfSight.get_collider() == player:
			currentState = states.SHOOT
		else:
			currentState = states.IDLE
			
	else:
		lineOfSight.enabled = false
		
	
func shoot() -> void:
	
	var instance = enemyLaser.instance()
	
	add_child(instance)
	
	instance.set_direction(directionToPlayer.normalized())
	
func on_ShootTimer_timeout() -> void:
	if currentState == states.SHOOT:
		shoot()
	
	
