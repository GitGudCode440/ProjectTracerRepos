extends TextureProgressBar

var health : int
@onready var healthText := get_parent().get_node("HealthText")

@onready var player : CharacterBody2D = get_tree().get_root().find_child("Player", true, false)
 
var tween : Tween


func _ready():
	
	
	healthText.show()
	show()
	
	kill_tween()
	
	health = player.health
	max_value = health
	value = health

func on_playerHealth_damage(_damage):
	health -= _damage
	
	kill_tween()
	
	tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "value", health, 3.0)


func _process(delta):
	if health <= 0:
		hide()
		healthText.hide()

func reset_health():
	_ready()

func kill_tween():
	if tween:
		if tween.is_running():
			tween.kill()

