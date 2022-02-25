extends StaticBody2D

enum states {IDLE, SHOOT}

var currentState : int 

var enemyLaser : Resource = preload("res://src/Bullet/EnemyBullet/EnemyBullet.tscn")

onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)
var directionToPlayer : Vector2 

var shootTimer : Timer = Timer.new()
var shootTime : float = 0.4

func _ready():
	currentState = states.IDLE
	
	add_child(shootTimer)
	
	shootTimer.connect("timeout", self, "on_ShootTimer_timeout")
	shootTimer.start(shootTime)
	
	
func _process(delta):
	
	directionToPlayer = (player.global_position - global_position)
	
	

func _on_Area2D_body_entered(body):
	if body == player:
		currentState = states.SHOOT

func _on_Area2D_body_exited(body):
	
	if body == player:
		currentState = states.IDLE
	
	
	
func shoot() -> void:
	
	var instance = enemyLaser.instance()
	
	add_child(instance)
	
	instance.set_direction(directionToPlayer.normalized())
	
func on_ShootTimer_timeout() -> void:
	if currentState == states.SHOOT:
		shoot()
	
	
