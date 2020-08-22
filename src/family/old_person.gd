extends FamilyMember
class_name OldPerson

export var _speed: float = 2.0

export var _animationSpeed: float = 1.0

var total_speed: float

# the speed_boost will be added to speed 
export var _speed_boost: float = 2.4
var _speed_boost_duration: float = 1.2

onready var _speed_boost_timer: Timer = $SpeedTimer
onready var animplayer: AnimationPlayer = $MaleOld/AnimationPlayer
onready var mesh: MeshInstance = $MaleOld/HumanArmature/Skeleton/OldMan

onready var texture_blue = load("res://models/Humans/Male_Old/male_Old_blue.jpg")
onready var texture_brown = load("res://models/Humans/Male_Old/male_Old_brown.jpg")
onready var texture_green = load("res://models/Humans/Male_Old/male_Old_green.jpg")
onready var texture_red = load("res://models/Humans/Male_Old/male_Old_red.jpg")
onready var texture_yellow = load("res://models/Humans/Male_Old/male_Old_yellow.jpg")

func _ready():
	randomize()
	var select_texture = [texture_blue, texture_brown, texture_green, texture_red, texture_yellow]
	var randomNumber = randi() % 5
	mesh.get_surface_material(0).albedo_texture = select_texture[randomNumber]

func _physics_process(delta: float):
	if _speed_boost_timer.is_stopped():
		total_speed = _speed  * _animationSpeed
		animplayer.play("OldManWalk")
		animplayer.set_speed_scale(_speed/1.5)
		
	else:
		 total_speed = _speed * _speed_boost
		 animplayer.play("OldManRun")


	_move_on_path(total_speed, delta)


func hears_bark():
	_speed_boost_timer.start(_speed_boost_duration)
	.hears_bark()
