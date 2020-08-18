extends KinematicBody
class_name Dog

export var speed = 10


var direction: Vector3 = Vector3()


onready var _bark_area: Area = $BarkArea
onready var _timer: Timer = $BarkArea/Timer

func _process(_delta):
	# reset the direction vector state
	direction = Vector3()
	
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")


func _physics_process(_delta):
	if direction != Vector3.ZERO:
		look_at(get_global_transform().origin + direction, Vector3.UP)
	
	move_and_slide(direction.normalized() * speed)



func pet_the_dog():
	# TODO
	pass
