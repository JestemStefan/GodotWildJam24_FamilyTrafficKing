extends Node
class_name LevelSettings

export var timer_duration = 60
export var happiness_threshold = 100
export(PackedScene) var next_level = null

func _ready():
	GameManager.setup_level(self)
