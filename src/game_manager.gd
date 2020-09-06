extends Node

const GUI = preload("res://src/ui/GUI.tscn")
const _win_screen = preload("res://src/levels/WinScreen.tscn")
const _game_over = preload("res://src/levels/GameOver.tscn")

onready var _root = get_tree().get_root()

var _current_level: LevelSettings = null

var _gui = null

var _rng = RandomNumberGenerator.new() setget, get_rng


func _ready():
	_rng.randomize()
	TimerManager.connect("time_is_up", self, "_go_next_level_or_game_over")


func load_first_level():
	_load_next_level(load("res://src/levels/testing/TestLevelNewPavedPaths.tscn"))


func get_rng():
	return _rng


func setup_level(level: LevelSettings):
	_current_level = level
	HappinessManager.set_happiness_threshold(level.happiness_threshold)
	TimerManager.start_timer(level.timer_duration)
	
	var tree = get_tree()
	HappinessManager.init_happiness_system(tree.get_nodes_in_group("people_paths"),
	tree.get_nodes_in_group("car_paths"), tree.get_nodes_in_group("dog")[0])
	
	NodeFinder.update_player_camera(level.get_node("Camera"))
	
	_gui = GUI.instance()
	_root.call_deferred("add_child", _gui)


func _load_next_level(next_level: PackedScene):
	var level: LevelSettings = next_level.instance()
	
	_root.add_child(level)
	
	
	_gui = GUI.instance()
	_root.add_child(_gui)
	
	_current_level = level


func _remove_ui_and_level():
	_gui.queue_free()
	_current_level.queue_free()


func _replace_level_with_next():
	_remove_ui_and_level()
	
	HappinessManager.reset_happiness()
	
	if _current_level.next_level != null:
		_load_next_level(_current_level.next_level)
	else:
		_load_and_add_level(_win_screen)


func _load_and_add_level(level: PackedScene):
	_remove_ui_and_level()
	_root.add_child(level.instance())


func _go_next_level_or_game_over():
	if HappinessManager.is_happiness_threshold_reached():
		_replace_level_with_next()
	else:
		_load_and_add_level(_game_over)
