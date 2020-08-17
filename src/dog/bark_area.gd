extends Area

export(float) var bark_duration = 0.25
export(float) var bark_stun_duration = 2

onready var _timer: Timer = $Timer
onready var _woof_text: RichTextLabel = $WoofText

func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("bark"):
		_bark()


func _bark():
	if not _timer.is_stopped():
		print("cooldown")
		return
		
	# TODO: play sound
	_woof_text.display(get_global_transform().origin)
	set_monitoring(true)
	_timer.start(bark_duration)
	print("bark!")


func _on_BarkArea_body_entered(body):
	print("%s detected" % body)
	# actually not need but why not for safety
	if body is FamilyMember:
		body.stun(bark_stun_duration)


func _on_Timer_timeout():
		set_monitoring(false)
