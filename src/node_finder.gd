extends Node

onready var _main = null


var _camera = null setget , get_player_camera

func _ready():
	_camera = get_tree().get_nodes_in_group("camera")[0]


func get_main():
	return _main


func update_player_camera(level_name):
	_camera = _main.get_node(level_name + "/Camera")


func get_player_camera():
	return _camera
