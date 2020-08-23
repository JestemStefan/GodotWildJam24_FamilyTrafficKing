extends KinematicBody

export var speed: int = 10

const HAPPINESS_LOST_ON_HONK = 20

onready var _path : PathFollow = get_parent()
onready var _car_animplayer: AnimationPlayer = $Car/AnimationPlayer
onready var _wait_time: Timer = $WaitTime
onready var mesh = $Car/CarArmature/Skeleton/Car
onready var _honk_label = $HonkLabel

const texture_Black = preload("res://models/Car/Car_Black.jpg")
const texture_Blue = preload("res://models/Car/Car_Blue.jpg")
const texture_Green = preload("res://models/Car/Car_Green.jpg")
const texture_Purple = preload("res://models/Car/Car_Purple.jpg")
const texture_Red = preload("res://models/Car/Car_Red.jpg")
const texture_Yellow = preload("res://models/Car/Car_Yellow.jpg")


var detected_fams_or_dog: Array = []
var driveSpeed: int = 0

var canDrive : int = 1
var isWaiting:bool = false


func _ready():
	randomize()
	var select_texture = [texture_Black, texture_Blue, texture_Green, texture_Purple, texture_Red, texture_Yellow]
	var rnd = GameManager.get_rng().randi_range(0, select_texture.size()-1)
	mesh.get_surface_material(0).albedo_texture = select_texture[rnd]
	
	_car_animplayer.play("Driving")


func _physics_process(delta):
	if detected_fams_or_dog.size() <= 0:
		canDrive = 1
	else:
		canDrive = 0
	if isWaiting == false:
		driveSpeed = lerp(driveSpeed, canDrive * speed, 0.075)
		
		_path.set_offset(_path.get_offset() + 0.1 * driveSpeed * delta)	


func _on_PeopleDetector_body_entered(body):
	if detected_fams_or_dog.size() <= 0:
		if driveSpeed <= 0:
			isWaiting = true
		_car_animplayer.play("Braking")
	
	# should not be needed but why not 
	if body is Dog or body is FamilyMember:
		detected_fams_or_dog.append(body)
		print("car %s detected %s" % [self, body])


func _on_PeopleDetector_body_exited(body):
	detected_fams_or_dog.erase(body)
	print("car %s undetected %s" % [self, body])

	if detected_fams_or_dog.size()  <= 0:
		_car_animplayer.play("SpeedingUp")

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Honking":
		HappinessManager.lose_happiness(HAPPINESS_LOST_ON_HONK)

func _on_AnimationPlayer_animation_finished(anim_name):
	print("Animation " + anim_name + " finished")

	match anim_name:
		"SpeedingUp": _car_animplayer.play("Driving")
		"Braking": _honk()

func _honk():
	_car_animplayer.play("Honking")
	_honk_label.display(global_transform.origin, HAPPINESS_LOST_ON_HONK)



