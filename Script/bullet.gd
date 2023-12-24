# scripted by Shin won young

class_name Bullet extends RigidBody2D

@onready var animation_player := $AnimationPlayer as AnimationPlayer

# bullet destroy
func destroy():
	animation_player.play(&"destroy")

# if bullet touches the enemy, enemy is destroyed
func _on_body_entered(body: Node):
	if body is Enemy:
		(body as Enemy).destroy()
