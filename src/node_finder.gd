extends Node

onready var _main = get_tree().get_root().get_node("Main")
# TODO: some kind of level loader and use that here or move this code or idk do something omg
var _camera = null setget , get_player_camera

func get_main():
	return _main

func update_player_camera(level_name):
	_camera = _main.get_node(level_name + "/Camera")


func get_player_camera():
	return _camera
