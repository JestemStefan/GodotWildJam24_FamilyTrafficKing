extends Node

signal happiness_updated

const MAX_HAPPINESS = 200

var _current_happiness = MAX_HAPPINESS / 2

func gain_happiness(amount):
	_current_happiness = min(MAX_HAPPINESS, _current_happiness + amount)
	_emit_happiness_signal()


func lose_happiness(amount):
	_current_happiness = max(0, _current_happiness - amount)
	_emit_happiness_signal()
	
	
func reset_happiness():
	_current_happiness = MAX_HAPPINESS / 2


func _emit_happiness_signal():
	emit_signal("happiness_updated", _current_happiness)
