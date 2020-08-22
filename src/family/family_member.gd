extends KinematicBody
class_name FamilyMember

const HAPPINESS_LOST_ON_BARK = 5

onready var _path : PathFollow = get_parent()

var detected_cars = []

func _ready():
	var car_detector = get_node("CarDetector")
	car_detector.connect("body_entered", self, "_detect_car")
	car_detector.connect("body_exited", self, "_undetect_car")


func _move_on_path(speed: float, delta: float):
	if detected_cars.empty():
		_path.set_offset(_path.get_offset() + speed * delta)


func _detect_car(body):
	detected_cars.append(body)


func _undetect_car(body):
	detected_cars.erase(body)


func hears_bark():
	HappinessManager.lose_happiness(HAPPINESS_LOST_ON_BARK)
