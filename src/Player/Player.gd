extends KinematicBody2D

export(int) var speed
export(float) var gravity
export(int) var jumpSpeed

var velocity : Vector2 = Vector2.ZERO
var direction : float

var bullet : Resource = preload("res://src/Bullet/PlayerBullet/PlayerBullet.tscn")


func _process(delta) -> void:
	
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta) -> void:
	
	
	move()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	apply_gravity()
	jump()
	
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
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jumpSpeed
	
func shoot() -> void:
	
	
	var bulletInstance = bullet.instance()
	
	
	add_child(bulletInstance)
	
	var shoot_position = get_local_mouse_position().normalized()
	bulletInstance.set_direction(shoot_position)
	
	
	
	
	
	
