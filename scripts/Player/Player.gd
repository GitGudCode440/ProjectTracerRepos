extends Character

""" 
	This is used for move and sliding kinematic body according to variables
	defined by input. It is also where shooting and animation mechanisms are
	implemented. Also has a life system
"""


export(int) var jumpSpeed


var bullet : Resource = preload("res://scenes/PlayerBullet.tscn")
var bulletDirection : Vector2

onready var animatedSprite : AnimatedSprite = $AnimatedSprite


func _ready():
	
	print(bullet)
	
	states.enter(self, null)


func _process(delta) -> void:
	
	check_lives()
	
	bulletDirection = get_local_mouse_position()
	
	
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	states.logic(delta)
	
	
	if global_position.y > 4000:
		get_tree().reload_current_scene()
	
func _physics_process(delta) -> void:
	
	
	states.physics_logic(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	apply_gravity()
	states.on_collisions(delta)
	
	
func apply_gravity() -> void:
	
	if !is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 1

	

	

	
	
