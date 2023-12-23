class_name MainGame extends Node2D

@onready var Level1 := $Level1 as Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _end_level1():
	# Remove the current level
	self.remove_child(Level1)
	Level1.call_deferred("free")
	# Add the next level
	var next_level_resource = load("res://Levels/Level2.tscn")
	var next_level = next_level_resource.instantiate()
	self.add_child(next_level)
	move_child(next_level, 0)
