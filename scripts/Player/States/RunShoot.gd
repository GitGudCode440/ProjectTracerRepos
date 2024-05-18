extends Shoot 


func enter() -> void:
	shootAnimation = "run_shoot"
	
	CameraShake.shake(0.1, 5)
	super.enter()
	
	
