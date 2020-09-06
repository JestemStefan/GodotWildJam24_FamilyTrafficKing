extends MeshInstance

onready var _path = get_parent()

func _process(delta):
	_path.set_offset(_path.get_offset() + 1 * delta)
