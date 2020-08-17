extends Area

export(float) var bark_duration = 0.25

onready var _timer: Timer = $Timer
onready var _woof_text: RichTextLabel = $WoofText

var detected_fams = []

func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("bark"):
		_bark()


func _bark():
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
	# actually not needed but why not for safety
	if body is FamilyMember:
		detected_fams.append(body)
		print("%s detected" % body)


func _on_BarkArea_body_exited(body):
	var body_index = detected_fams.find(body)
	if body_index >= 0:
		detected_fams.remove(body_index)
		print("%s undetected" % body)
