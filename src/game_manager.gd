extends Node

const _levels = ["Level2", "Level3"]

const GUI = preload("res://src/ui/GUI.tscn")


onready var _main = NodeFinder.get_main()

var _current_lvl_idx = 0

var _gui = null

var _rng = RandomNumberGenerator.new() setget, get_rng

func _ready():
	_rng.randomize()
	# _load_and_add_level("MainMenu")


func load_first_level():
	_main.get_node("MainMenu").queue_free()
	_load_current_level_and_UI()
	TimerManager.connect("time_is_up", self, "_go_next_level_or_game_over")


func get_rng():
	return _rng


func _load_current_level_and_UI():
	var _current_level_name = _get_current_level_name()
	var level = _load_level(_current_level_name)
	
	HappinessManager.set_happiness_threshold(level.happiness_threshold)
	TimerManager.start_timer(level.timer_duration)
	
	_main.add_child(level)
	var tree = get_tree()
	HappinessManager.init_happiness_system(tree.get_nodes_in_group("people_paths"),
	tree.get_nodes_in_group("car_paths"))
	
	_gui = GUI.instance()
	_main.add_child(_gui)
	
	NodeFinder.update_player_camera(_current_level_name)
	


func _load_level(level_name) -> LevelSettings:
	return load("res://src/levels/%s.tscn" % level_name).instance()

func _load_and_add_level(level_name):
	_main.add_child(_load_level(level_name))

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
	if _current_lvl_idx < _levels.size():
		_load_current_level_and_UI()
	else:
		_load_and_add_level("WinScreen")


func _go_next_level_or_game_over():
	if HappinessManager.is_happiness_threshold_reached():
		_replace_level_with_next()
	else:
		_remove_ui_and_level()
		_load_and_add_level("GameOver")
