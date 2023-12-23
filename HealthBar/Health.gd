extends CanvasLayer

var hearts = 3
var maxhearts = 3
@onready var player = get_parent().get_node("player")
@onready var healthUI = $HealthUI

# Called when the node enters the scene tree for the first time.
func _ready():
	if player != null :
		player.health_changed.connect(change_texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_texture(value):
	hearts = value
	if hearts >=0:
		if hearts<= maxhearts:
			healthUI.size.x = hearts * 16
