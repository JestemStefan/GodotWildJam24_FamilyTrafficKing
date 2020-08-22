extends Node

onready var _main = NodeFinder.get_main()

const _levels = ["TestLevelNewPavedPaths", "TutorialLevel1", "Level2", "Level3"]
var _current_lvl_idx = 0

const GUI = preload("res://src/ui/GUI.tscn")
var _gui = null

var _rng = RandomNumberGenerator.new() setget, get_rng

	
func _ready():
	_rng.randomize()
	# TODO: load main menu instead
	_load_current_level_and_UI()
	HappinessManager.connect("happiness_updated", self, "_change_level_if_happiness_reached_threshold")


func _load_current_level_and_UI():
	var _current_level_name = _get_current_level_name()
	_load_level(_current_level_name)
	_gui = GUI.instance()
	NodeFinder.update_player_camera(_current_level_name)
	_main.add_child(_gui)
	

func _load_level(level_name):
	_main.add_child(load("res://levels/%s.tscn" % level_name).instance())


func _get_current_level_name():
	return _levels[_current_lvl_idx]


func _remove_ui_and_level():
	_gui.queue_free()
	_main.get_node(_get_current_level_name()).queue_free()


func _replace_level_with_next():
	_remove_ui_and_level()
	HappinessManager.reset_happiness()
	# load and instantiate next level if there is more
	_current_lvl_idx += 1
	if _current_lvl_idx <= _levels.size():
		_load_current_level_and_UI()
	else:
		_load_level("WinScreen")


func _change_level_if_happiness_reached_threshold(happiness_value):
	if happiness_value >= HappinessManager.MAX_HAPPINESS:
		_replace_level_with_next()
	elif happiness_value <= 0:
		_remove_ui_and_level()
		_load_level("GameOver")


func get_rng():
	return _rng
