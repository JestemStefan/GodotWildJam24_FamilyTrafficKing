extends Spatial

onready var target = NodeFinder.get_dog()

func _ready():
	NodeFinder.set_player_camera($Camera)


func _physics_process(delta):
	set_translation(lerp(get_global_transform().origin, 
		target.get_global_transform().origin, 0.05))
