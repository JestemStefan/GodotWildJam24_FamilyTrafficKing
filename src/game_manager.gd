extends Node

onready var _main = NodeFinder.get_main()

var _levels = ["TutorialLevel1", "Level2", "Level3"]
var _current_lvl_idx = 0

const GUI = preload("res://src/ui/GUI.tscn")
var _gui = null


func _ready():
	_load_current_level_and_UI()
	HappinessManager.connect("happiness_updated", self, "_next_level_if_happiness_reached_max")


func _load_level(level_name):
	_main.add_child(load("res://levels/%s.tscn" % level_name).instance())


func _get_current_level_name():
	return _levels[_current_lvl_idx]


func _load_current_level_and_UI():
	var _current_level_name = _get_current_level_name()
	_load_level(_current_level_name)
	_gui = GUI.instance()
	NodeFinder.update_player_camera(_current_level_name)
	_main.add_child(_gui)
	

func _replace_level_with_next():
	# remove UI to reset it
	_gui.queue_free()
	
	# remove current level
	_main.get_node(_levels[_current_lvl_idx]).queue_free()
		
	# load and instantiate next level if there is more
	_current_lvl_idx += 1
	if _current_lvl_idx <= _levels.size():
		_load_current_level_and_UI()
	else:
		_load_level("win_screen")


func _next_level_if_happiness_reached_max(happiness_value):
	if happiness_value >= HappinessManager.MAX_HAPPINESS:
		_replace_level_with_next()
