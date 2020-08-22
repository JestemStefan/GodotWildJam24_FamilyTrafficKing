extends Node

signal happiness_updated

const MAX_HAPPINESS = 100
const MIN_HAPPINESS = 0

var _current_happiness = 50


func _ready():
	pass # TODO: set min/max happiness range in GUI?


func gain_happiness(amount):
	_current_happiness = min(MAX_HAPPINESS, _current_happiness + amount)
	_emit_happiness_signal()


func lose_happiness(amount):
	_current_happiness = max(0, _current_happiness - amount)
	_emit_happiness_signal()
	

func _emit_happiness_signal():
	emit_signal("happiness_updated", _current_happiness)
