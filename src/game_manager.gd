extends Node

const _levels = ["Level2", "Level3"]

const GUI = preload("res://src/ui/GUI.tscn")


onready var _main = NodeFinder.get_main()

var _current_lvl_idx = 0

var _gui = null

var _rng = RandomNumberGenerator.new() setget, get_rng

var _current_level_duration = 0

func _ready():
	_rng.randomize()
	_load_level("MainMenu")


func load_first_level():
	_main.get_node("MainMenu").queue_free()
	_load_current_level_and_UI()
	NodeFinder.get_level_timer().connect("timeout", self, "_check_level_time_is_up")	


func _load_current_level_and_UI():
	var _current_level_name = _get_current_level_name()
	var level = _load_level(_current_level_name)
	
	HappinessManager.set_happiness_threshold(level.happiness_threshold)
	_current_level_duration = level.timer_duration
	
	_gui = GUI.instance()
	_main.add_child(_gui)
	
	NodeFinder.update_player_camera(_current_level_name)
	
	NodeFinder.get_level_timer().start()


func _load_level(level_name) -> LevelSettings:
	var new_level = load("res://levels/%s.tscn" % level_name).instance()
	_main.add_child(new_level)
	return new_level


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


func _check_level_time_is_up():
	_current_level_duration -= 1
	if _current_level_duration <= 0:
		_current_level_duration = 0
		NodeFinder.get_level_timer().stop()
		_go_next_level_or_game_over()


func _go_next_level_or_game_over():
	if HappinessManager.is_happiness_threshold_reached():
		_replace_level_with_next()
	else:
		_remove_ui_and_level()
		_load_level("GameOver")


func get_rng():
	return _rng


func get_current_level_duration():
	return _current_level_duration
