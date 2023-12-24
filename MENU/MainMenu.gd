extends Control
#LimHwanJae
func _on_start_pressed():
	$BGM2.play()
	get_tree().change_scene_to_file("res://MainGame.tscn")



func _on_options_pressed():
	$BGM2.play()
	get_tree().change_scene_to_file("res://MENU/Options.tscn")



func _on_exit_pressed():
	$BGM2.play()
	get_tree().quit()
	


func _on_credit_pressed():
	$BGM2.play()
	get_tree().change_scene_to_file("res://MENU/Credit.tscn")


func _on_story_pressed():
	$BGM2.play()
	get_tree().change_scene_to_file("res://MENU/Story.tscn")
