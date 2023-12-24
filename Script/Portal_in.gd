# scripted by Shin won young

extends Area2D

@export var portal_out : CollisionObject2D = null
@export var is_ns : bool = false
var Level1 : Node2D

func _on_body_entered(body):
	var player : Player = body as Player
	if player:
		
		# if is Next Scene portal, player go to next level
		if is_ns:
			var main := get_parent().get_parent().get_parent() as MainGame
			player.respawn()
			main._end_level1()
			return
		
		# if exit portal exist, player go to portal_out
		if portal_out != null:
			player.global_position = portal_out.global_position
