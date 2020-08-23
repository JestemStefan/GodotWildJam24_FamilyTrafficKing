extends Area

export(float) var bark_duration = 0.25

onready var _timer: Timer = $Timer
onready var _woof_text: Label = $WoofText

onready var barkBubble: Spatial = $BarkBubble
onready var _animplayer: AnimationPlayer = $AnimationPlayer
onready var camera: Camera = get_tree().get_root().get_camera()

var detected_fams = []

func _process(delta):
	bubble()
	
func bark():
	if not _timer.is_stopped():
		return
	
	for fam in detected_fams:
		fam.hears_bark()
	
	_animplayer.play("BarkAnimation")
	_timer.start(bark_duration)


func _on_BarkArea_body_entered(body):
	detected_fams.append(body)


func _on_BarkArea_body_exited(body):
	detected_fams.erase(body)

func bubble():
	barkBubble.look_at(camera.global_transform.origin,Vector3(0,1,0))
