# scripted by Shin won young

class_name Attack extends Marker2D

const BULLET_VELOCITY = 500.0
const Bullet = preload("res://Character/bullet.tscn")

@onready var sound_shoot := $Shoot as AudioStreamPlayer2D
@onready var timer := $Cooldown as Timer

# Shooting Method
func shoot(head_dir: bool = false) -> bool:
	var direction : float = -1.0 if head_dir else 1.0
	
	# If attack is in cooldown, don't work.
	if not timer.is_stopped():
		return false
		
	# instantiate bullet
	var bullet := Bullet.instantiate() as Bullet
	bullet.global_position = global_position
	# bullet init
	bullet.global_position.x += direction * 15
	bullet.global_position.y += 20
	bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0.0)
	bullet.set_as_top_level(true)
	add_child(bullet)
	sound_shoot.play()
	
	# bullet live timer
	timer.start()
	
	return true
