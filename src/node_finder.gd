extends Node

var _dog: Dog = null setget set_dog , get_dog
var _camera: Camera = null setget set_player_camera, get_player_camera

func set_player_camera(camera: Camera):
	_camera = camera


func get_player_camera() -> Camera:
	return _camera


func set_dog(dog: Dog):
	_dog = dog


func get_dog() -> Dog:
	return _dog
