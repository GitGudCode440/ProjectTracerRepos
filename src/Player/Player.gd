extends KinematicBody2D

export(int) var speed
export(float) var gravity
export(int) var jumpSpeed

var velocity : Vector2 = Vector2.ZERO
var direction : float



func _process(delta) -> void:
	
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	

func _physics_process(delta) -> void:
	
	
	move()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	apply_gravity()
	jump()
	
func move() -> void:
	
	velocity.x = direction * speed
	
func apply_gravity() -> void:
	
	if !is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 1

func jump() -> void:
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jumpSpeed
	
	
	
	
	
