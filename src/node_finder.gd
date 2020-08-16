extends Node

onready var _main = get_tree().get_root().get_node("Main")
onready var _camera = _main.get_node("Camera")

func get_player_camera():
	return _camera
