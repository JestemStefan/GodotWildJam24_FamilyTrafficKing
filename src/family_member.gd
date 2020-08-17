extends KinematicBody
class_name FamilyMember

export(float) var speed: float = 3.0

onready var _path : PathFollow = get_parent()
onready var _stun_timer: Timer = $StunTimer

func _physics_process(delta: float):
	if _stun_timer.is_stopped():
		_path.set_offset(_path.get_offset() + speed * delta)

func stun(duration: float):
	_stun_timer.start(duration)
