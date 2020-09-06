extends KinematicBody
class_name Car

signal honked

export var speed: int = 10

onready var _path : PathFollow = get_parent()
onready var _car_animplayer: AnimationPlayer = $Car/AnimationPlayer
onready var _wait_time: Timer = $WaitTime
onready var _honk_label = $HonkLabel

var detected_entities: Array = []
var driveSpeed: int = 0

var canDrive : int = 1

const _textures = [
	preload("res://models/Car/Car_Black.jpg"),
	preload("res://models/Car/Car_Blue.jpg"),
	preload("res://models/Car/Car_Green.jpg"),
	preload("res://models/Car/Car_Purple.jpg"),
	preload("res://models/Car/Car_Red.jpg"),
	preload("res://models/Car/Car_Yellow.jpg")
]

func _ready():
	TextureRandomizer.apply_random_texture($Car/CarArmature/Skeleton/Car, _textures)

	_car_animplayer.play("Driving")


func _physics_process(delta):
	if detected_entities.size() <= 0:
		canDrive = 1
	else:
		canDrive = 0

	driveSpeed = lerp(driveSpeed, canDrive * speed, 0.075)
		
	_path.set_offset(_path.get_offset() + 0.1 * driveSpeed * delta)


func _on_PeopleDetector_body_entered(body):
	if detected_entities.size() <= 0:
		_car_animplayer.play("Braking")
	
	detected_entities.append(body)
	print("car %s detected %s" % [self, body])


func _on_PeopleDetector_body_exited(body):
	detected_entities.erase(body)
	print("car %s undetected %s" % [self, body])

	if detected_entities.size() <= 0:
		_car_animplayer.play("SpeedingUp")


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Honking":
		emit_signal("honked")


func _on_AnimationPlayer_animation_finished(anim_name):
	print("Animation " + anim_name + " finished")

	match anim_name:
		"SpeedingUp": _car_animplayer.play("Driving")
		"Braking": _honk()

func _honk():
	_car_animplayer.play("Honking")
	_honk_label.display(global_transform.origin, HappinessManager.HAPPINESS_LOST_HONK)
