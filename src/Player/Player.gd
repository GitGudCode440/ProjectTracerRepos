extends KinematicBody2D

""" 
	This is used for move and sliding kinematic body according to variables
	defined by input. It is also where shooting and animation mechanisms are
	implemented. Also has a life system
"""

export(int) var lives

export(int) var speed
export(int) var jumpSpeed

export(float) var gravity

var isJumping : bool = false

var velocity : Vector2 = Vector2.ZERO
var direction : float

var bullet : Resource = preload("res://src/Bullet/PlayerBullet/PlayerBullet.tscn")

onready var animatedSprite : AnimatedSprite = $AnimatedSprite

func take_damage() -> void: #Called by enemies to inflict damage on Player
	
	lives -= 1

func _ready():
	
	animatedSprite.play("idle")
	


func _process(delta) -> void:
	
	check_lives()
	animate()
	
	
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if global_position.y > 4000:
		get_tree().reload_current_scene()
	
func _physics_process(delta) -> void:
	
	
	move()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	apply_gravity()
	jump()
	
	
func check_lives() -> void:
	if lives == 0:
		get_tree().reload_current_scene()
		
	
func animate() -> void:
	
	
	if isJumping:
		animatedSprite.play("jump")
		return 
	
	
	if direction > 0:
		animatedSprite.flip_h = false
		animatedSprite.play("run")
	elif direction < 0:
		animatedSprite.flip_h = true
		animatedSprite.play("run")
	else:
		animatedSprite.play("idle")
	
	
	

func move() -> void:
	
	if abs(direction) > 0:
		velocity.x = lerp(0, direction * speed, 0.8)
	else:
		velocity.x = lerp(velocity.x, 0, 0.8)
		
	
func apply_gravity() -> void:
	
	if !is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 1

func jump() -> void:
	
	if is_on_floor():
		isJumping = false 
		print("Set false")
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jumpSpeed
		animatedSprite.play("jump")
		isJumping = true
		print("Set true")
	
	

	
func shoot() -> void:
	
	
	var bulletInstance = bullet.instance()
	
	
	add_child(bulletInstance)
	
	var shoot_position = get_local_mouse_position().normalized()
	bulletInstance.set_direction(shoot_position)
	
	
	
