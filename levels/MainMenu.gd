extends Node


func _on_Start_pressed():
	GameManager.load_first_level()


func _on_Quit_pressed():
	get_tree().quit()


func _on_HSlider_value_changed(value):
	#change sound volume
	print(Settings.masterVolume)
	
	Settings.masterVolume = value
	
	print(Settings.masterVolume)
