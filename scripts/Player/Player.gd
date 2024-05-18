extends Character

""" 
	This is used for move and sliding kinematic body according to variables
	defined by states. It is also where shooting and animation mechanisms are
	implemented. Also has a life system
"""

@export var jumpSpeed: int

@export_range(0.0, 1.0, 0.05) var accelerationRate: float 
@export_range(0.0, 1.0, 0.05) var deccelerationRate: float

var bullet : Resource = preload("res://scenes/PlayerBullet.tscn")
var bulletDirection : Vector2

@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
 
func take_damage(_damage : int) -> void:
	super.take_damage(_damage)
	get_tree().call_group("ScoreText", "gain_score", 100)
	get_tree().call_group("HealthBar", "on_playerHealth_damage", _damage)
	CameraShake.shake(0.3, 18)


func check_lives() -> void:
	if health == 0:
		game_over()
		

func _ready() -> void:
	states.enter(self, null)
	
	
func _process(delta) -> void:
	
	check_lives()
	
	bulletDirection = get_local_mouse_position()
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	states.logic(delta)
	
	if global_position.y > 4000:
		game_over()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
func _physics_process(delta) -> void:
	
	
	states.physics_logic(delta)
	
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity
	
	apply_gravity()
	states.on_collisions(delta)
	
	
func apply_gravity() -> void:
	
	if !is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 1

func game_over() -> void:
	get_tree().call_group("Game", "show_game_over")
	queue_free()
	

