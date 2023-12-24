extends Area2D
#LimHwanJae
@onready var vic = $victory
@onready var main = $"Back to Main"
@onready var quit = $Quit

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	get_tree().change_scene_to_file("res://Levels/Ending.tscn")


