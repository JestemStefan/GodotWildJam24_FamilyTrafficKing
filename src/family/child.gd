extends FamilyMember
class_name Child

var _speed: float = 8.0
var _bark_stun_duration: float = 1.1

onready var _stun_timer: Timer = $StunTimer
onready var _anim_player: AnimationPlayer = $BOI/AnimationPlayer


func _physics_process(delta: float):
	if _stun_timer.is_stopped():
		_move_on_path(_speed, delta)
		_anim_player.play("Skip")


func hears_bark():
	_stun_timer.start(_bark_stun_duration)
	_anim_player.play("Stun")
	.hears_bark()
