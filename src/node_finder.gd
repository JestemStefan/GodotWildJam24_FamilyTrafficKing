extends Node

onready var _main = get_tree().get_root().get_node("Main")
# TODO: some kind of level loader and use that here or move this code or idk do something omg
onready var _camera = _main.get_node("TestingLevel/Camera")

func get_player_camera():
	return _camera
