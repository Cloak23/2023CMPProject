class_name GameOver extends Control

@onready var player := self.get_parent().get_node("./Player") as Player

func _on_button_pressed():
	visible = false
	player.respawn()
