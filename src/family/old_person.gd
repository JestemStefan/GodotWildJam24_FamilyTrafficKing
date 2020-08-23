extends FamilyMember
class_name OldPerson

export var _speed: float = 6

export var _animationSpeed: float = 1.0

var total_speed: float

# the speed_boost will be added to speed 
export var _speed_boost: float = 1.8
var _speed_boost_duration: float = 1.2

onready var _speed_boost_timer: Timer = $SpeedTimer
onready var animplayer: AnimationPlayer = $MaleOld/AnimationPlayer
onready var mesh: MeshInstance = $MaleOld/HumanArmature/Skeleton/OldMan

const texture_blue = preload("res://models/Humans/Male_Old/male_Old_blue.jpg")
const texture_brown = preload("res://models/Humans/Male_Old/male_Old_brown.jpg")
const texture_green = preload("res://models/Humans/Male_Old/male_Old_green.jpg")
const texture_red = preload("res://models/Humans/Male_Old/male_Old_red.jpg")
const texture_yellow = preload("res://models/Humans/Male_Old/male_Old_yellow.jpg")

func _ready():
	var select_texture = [texture_blue, texture_brown, texture_green, texture_red, texture_yellow]
	var rnd = GameManager.get_rng().randi_range(0, select_texture.size() - 1)
	mesh.get_surface_material(0).albedo_texture = select_texture[rnd]

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
