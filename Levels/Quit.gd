extends Button



func _on_pressed():
	$"../BGM2".play()
	get_tree().quit()
