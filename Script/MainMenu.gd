extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://MENU/MainGame.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://MENU/Options.tscn")



func _on_exit_pressed():
	get_tree().quit()


func _on_credit_pressed():
	get_tree().change_scene_to_file("res://MENU/Credit.tscn")


func _on_story_pressed():
	get_tree().change_scene_to_file("res://MENU/Story.tscn")