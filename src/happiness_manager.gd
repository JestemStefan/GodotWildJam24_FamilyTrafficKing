extends Node

signal happiness_updated

var _happiness_threshold = 128

var _current_happiness = 0


func set_happiness_threshold(threshold):
	_happiness_threshold = threshold


func get_happiness_threshold():
	return _happiness_threshold


func is_happiness_threshold_reached():
	return _current_happiness >= _happiness_threshold


func gain_happiness(amount):
	_current_happiness = _current_happiness + amount
	_emit_happiness_signal()


func lose_happiness(amount):
	_current_happiness = max(0, _current_happiness - amount)
	_emit_happiness_signal()
	
	
func reset_happiness():
	_current_happiness = 0


func _emit_happiness_signal():
	emit_signal("happiness_updated", _current_happiness)
