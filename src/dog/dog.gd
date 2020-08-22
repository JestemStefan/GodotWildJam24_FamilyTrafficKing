extends KinematicBody
class_name Dog

export var speed = 10
export var isBarking: bool = false

var direction: Vector3 = Vector3()


onready var _anim_player: AnimationPlayer = $DogAnimated/AnimationPlayer
onready var bark_timer: Timer = $BarkArea/Timer

func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("bark"):
		isBarking = true
		_anim_player.play("Bark")

func _process(_delta):	
	# reset the direction vector state
	direction = Vector3()
	
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	
	

func _physics_process(_delta):
	if isBarking:
		direction = Vector3.ZERO
	else:
		if direction != Vector3.ZERO:
			look_at(get_global_transform().origin + direction, Vector3.UP)
			_anim_player.play("RunCycle")
		elif direction == Vector3.ZERO:
				_anim_player.play("Idle")
		
	move_and_slide(direction.normalized() * speed)



func pet_the_dog():
	# TODO
	pass



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Bark":
		isBarking = false
