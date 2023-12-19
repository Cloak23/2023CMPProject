extends Area2D

@export var portal_out : CollisionObject2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	var player : Player = body as Player
	if player:
		player.global_position = portal_out.global_position
