extends Control
@onready var MUSIC_BUS_ID =  AudioServer.get_bus_index("Music")
func _on_volume_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	get_tree().change_scene_to_file("res://MENU/MainMenu.tscn")



func volume(bus_index, value) :
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)

func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)

func _on_sound_fx_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
