class_name Gun extends Marker2D
## Represents a weapon that spawns and shoots bullets.
## The Cooldown timer controls the cooldown duration between shots.


const BULLET_VELOCITY = 500.0
const Bullet = preload("res://Character/bullet.tscn")

@onready var sound_shoot := $Shoot as AudioStreamPlayer2D
@onready var timer := $Cooldown as Timer


# This method is only called by Player.gd.
func shoot(head_dir: bool = false) -> bool:
	var direction : float = -1.0 if head_dir else 1.0
	if not timer.is_stopped():
		return false
	var bullet := Bullet.instantiate() as Bullet
	bullet.global_position = global_position
	bullet.global_position.x += direction * 15
	bullet.global_position.y += 20
	bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0.0)

	bullet.set_as_top_level(true)
	add_child(bullet)
	sound_shoot.play()
	timer.start()
	return true
