extends Area2D

@onready var vic = $victory
@onready var main = $"Back to Main"
@onready var quit = $Quit

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	$ColorRect.show()
	vic.show()
	main.show()
	quit.show()


