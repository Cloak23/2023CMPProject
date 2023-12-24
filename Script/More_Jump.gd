# scripted by Shin won young

extends Area2D

var visible_time : float = 0.0
var visible_max_time : float = 4


func _process(delta):
	# infinite respawn item
	# use visible to turn on and off
	if !visible:
		visible_time += delta
	if visible_time >= visible_max_time:
		visible = true
		visible_time = 0

func _on_body_entered(body):
	if !visible:
		return
	
	# if player earn the item, player can more jump
	var player : Player = body as Player
	player.more_jump = true
	visible = false
