extends Node

onready var _main = null


var _camera: Camera = null setget , get_player_camera


func get_main():
	return _main


func update_player_camera(camera: Camera):
	_camera = camera


func get_player_camera():
	return _camera
