extends Area

export(float) var bark_duration = 0.25

onready var _timer: Timer = $Timer
onready var _woof_text: RichTextLabel = $WoofText

var detected_fams = []


func bark():
	if not _timer.is_stopped():
		print("cooldown")
		return
	
	# TODO: play sound
	for fam in detected_fams:
		fam.hears_bark()
	_woof_text.display(get_global_transform().origin)
	_timer.start(bark_duration)
	print("bark!")


func _on_BarkArea_body_entered(body):
	detected_fams.append(body)
	print("%s detected" % body)


func _on_BarkArea_body_exited(body):
	detected_fams.erase(body)
	print("%s undetected" % body)
