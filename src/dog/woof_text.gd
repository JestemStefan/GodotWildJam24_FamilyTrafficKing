extends Label

export var y_offset = 60
onready var _animation = $AnimationPlayer


func display(position):
	var text_pos = NodeFinder.get_player_camera().unproject_position(position)
	text_pos.y -= y_offset
	set_position(text_pos)
	_animation.play("slide_up_n_fade")
