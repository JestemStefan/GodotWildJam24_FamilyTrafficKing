extends Label

export var y_offset = 60
onready var _animation = $AnimationPlayer


func display(position, happiness_val):
	var text_pos = NodeFinder.get_player_camera().unproject_position(position)
	text_pos.y -= y_offset
	set_position(text_pos)
	set_text("Pet! +%d happiness" % happiness_val)
	_animation.play("text_slide_up_fade")
