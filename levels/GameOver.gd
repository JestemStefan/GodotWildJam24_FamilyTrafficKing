extends Node


func _on_Start_pressed():
	GameManager.load_first_level()


func _on_Quit_pressed():
	get_tree().quit()
