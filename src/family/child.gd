extends FamilyMember
class_name Child

var _speed: float = 6.0
var _bark_stun_duration: float = 2.0

onready var _stun_timer: Timer = $StunTimer


func _physics_process(delta: float):
	if _stun_timer.is_stopped():
		_move_on_path(_speed, delta)


func hears_bark():
	_stun_timer.start(_bark_stun_duration)
