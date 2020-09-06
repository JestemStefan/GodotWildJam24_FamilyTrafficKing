extends KinematicBody
class_name FamilyMember

signal heard_bark


onready var _path : PathFollow = get_parent()

var _detected_cars = []

func _ready():
	var car_detector = get_node("CarDetector")
	car_detector.connect("body_entered", self, "_detect_car")
	car_detector.connect("body_exited", self, "_undetect_car")


func _move_on_path(speed: float, delta: float):
	if _detected_cars.empty():
		_path.set_offset(_path.get_offset() + speed * delta)


func _detect_car(body):
	_detected_cars.append(body)


func _undetect_car(body):
	_detected_cars.erase(body)


func hears_bark():
	emit_signal("heard_bark")
