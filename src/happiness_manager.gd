extends Node

signal happiness_updated

const HAPPINESS_LOST_BARK = 5
const HAPPINESS_LOST_HONK = 20
const HAPPINESS_GAIN_ON_GOAL = 30

var _happiness_threshold = 128

var _current_happiness = 0


func init_happiness_system(people_paths: Array, car_paths: Array):
	for spawner_path in people_paths:
		spawner_path.connect("spawned_person", self, "_connect_bark_loss")
		spawner_path.connect("person_reached_goal", self, "_gain_happiness", HAPPINESS_GAIN_ON_GOAL)
	
	for car_path in car_paths:
		car_path.connect("spawned_car", self, "_connect_honk_loss")


func _connect_bark_loss(person: FamilyMember):
	person.connect("heard_bark", self, "_lose_happiness", [HAPPINESS_LOST_BARK])


func _connect_honk_loss(car: Car):
	car.connect("honked", self, "_lose_happiness", [HAPPINESS_LOST_HONK])


func _lose_happiness_on_barked():
	_lose_happiness(HAPPINESS_LOST_BARK)


func set_happiness_threshold(threshold):
	_happiness_threshold = threshold


func get_happiness_threshold():
	return _happiness_threshold


func is_happiness_threshold_reached():
	return _current_happiness >= _happiness_threshold


func gain_happiness(amount):
	_current_happiness = _current_happiness + amount
	_emit_happiness_signal()


func reset_happiness():
	_current_happiness = 0


func _lose_happiness(amount: int):
	_current_happiness = max(0, _current_happiness - amount)
	_emit_happiness_signal()

func _emit_happiness_signal():
	emit_signal("happiness_updated", _current_happiness)
