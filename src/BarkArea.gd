extends Area

export(float) var bark_duration = 0.5

onready var _timer: Timer = $Timer

func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("bark"):
		_bark()


func _bark():
	if not _timer.is_stopped():
		print("cooldown")
		return
	# TODO: play sound
	set_monitoring(true)
	_timer.start(bark_duration)
	print("bark!")

func _on_Timer_timeout():
	_timer.stop()
	set_monitoring(false)


func _on_BarkArea_body_entered(body):
	# TODO
	print("%s detected")
