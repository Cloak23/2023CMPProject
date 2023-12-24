# scripted by Shin won young

class_name MainGame extends Node2D

@onready var Level1 := $Level1 as Node2D

# end first level
func _end_level1():
	# delete
	self.remove_child(Level1)
	Level1.call_deferred("free")
	
	# create
	var next_level_resource = load("res://Levels/Level2.tscn")
	var next_level = next_level_resource.instantiate()
	self.add_child(next_level)
	
	# to the top level
	move_child(next_level, 0)
