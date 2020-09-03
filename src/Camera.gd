extends Spatial

onready var target = get_parent().get_node("Dog")

func _physics_process(delta):
	set_translation(lerp(get_global_transform().origin, target.get_global_transform().origin, 0.05))
