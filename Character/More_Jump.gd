extends Area2D

var visible_time : float = 0.0
var visible_max_time : float = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !visible:
		visible_time += delta
	if visible_time >= visible_max_time:
		visible = true
		visible_time = 0

func _on_body_entered(body):
	if !visible:
		return
		
	var player : Player = body as Player
	player.more_jump = true
	visible = false
