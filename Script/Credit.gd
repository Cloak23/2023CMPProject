extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://MENU/MainMenu.tscn")
	$BGM2.play()
