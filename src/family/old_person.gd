extends FamilyMember
class_name OldPerson

var _speed: float = 3.0

# the speed_boost will be added to speed 
var _speed_boost: float = 3.0
var _speed_boost_duration: float = 2.0

onready var _speed_boost_timer: Timer = $SpeedTimer


func _physics_process(delta: float):
	var total_speed = _speed if _speed_boost_timer.is_stopped() else _speed + _speed_boost
	_move_on_path(total_speed, delta)


func hears_bark():
	_speed_boost_timer.start(_speed_boost_duration)
