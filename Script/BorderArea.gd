# scripted by Shin won young

extends Area2D

# when player touch the Area, kill the player
func _on_body_entered(body):
	var player : Player = body as Player
	if player:
		player.dead();
