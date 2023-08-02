extends StaticBody2D

export(int) var lives
export(int) var detectionRange 

enum states {IDLE, SHOOT}
var currentState : int 

onready var lineOfSight : RayCast2D = $LineOfSight
const ATTACK_RANGE_OFFSET = 200


onready var enemyLaser : Resource = preload("res://scenes/EnemyBullet.tscn")

onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)
var distanceToPlayer : Vector2 
var directionToPlayer : Vector2

var shootTimer : Timer = Timer.new()
export(float) var shootTime

onready var damageSound : AudioStreamPlayer = $DamageSound

func take_damage(_damage : int) -> void:
	lives -= _damage
	damageSound.play()
	CameraShake.shake(1, 1.1)
	get_tree().call_group("ScoreText", "gain_score", 50)
	

func check_lives() -> void: #Checks if lives are zero
	if lives == 0:
		get_tree().call_group("ScoreText", "gain_score", 500)
		queue_free()


func _ready():
	currentState = states.IDLE
	
	lineOfSight.cast_to.y = detectionRange - ATTACK_RANGE_OFFSET
	
	add_child(shootTimer)
	
	shootTimer.connect("timeout", self, "on_ShootTimer_timeout")
	shootTimer.start(shootTime)
	
	
	
func _process(delta):
	
	#Checks if lives are zero
	check_lives()
	
	#Stores distance and direction to the player
	
	if is_instance_valid(player):
		distanceToPlayer = (player.global_position - global_position)
	else:
		distanceToPlayer = Vector2.INF
	
	directionToPlayer = distanceToPlayer.normalized()
	
	
	#Calculates the amount of rotation needed in relation to the player
	#And sets RayCast rotation to the rotation
	var angleOfRotation = directionToPlayer.angle_to(Vector2.DOWN)
	
	lineOfSight.rotation = -angleOfRotation

	
	
	#Code for detection
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
	
	
