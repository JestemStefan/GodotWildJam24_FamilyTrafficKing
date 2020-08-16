extends KinematicBody

export var speed = 1

onready var _path : PathFollow = get_parent()

func _physics_process(delta):
	_path.set_offset(_path.get_offset() + (speed*delta))
