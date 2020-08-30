extends Node

signal time_is_up

var _timer = Timer.new()
var _current_level_duration = 0.0


func _ready():
	add_child(_timer)
	_timer.connect("timeout", self, "_update_time")


func get_timer() -> Timer:
	return _timer


func start_timer(duration: float):
	_current_level_duration = duration
	_timer.start(1)


func get_remaining_time() -> float:
	return _current_level_duration


func _update_time():
	_current_level_duration -= 1
	if _current_level_duration <= 0:
		_timer.stop()
		emit_signal("time_is_up")
