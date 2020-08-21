extends KinematicBody
class_name Dog

export var speed = 10


var direction: Vector3 = Vector3()


onready var _anim_tree: AnimationTree = $DogAnimated/AnimationTree


func _process(_delta):
	# reset the direction vector state
	direction = Vector3()
	
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")


func _physics_process(_delta):
	if direction != Vector3.ZERO:
		look_at(get_global_transform().origin + direction, Vector3.UP)
		_anim_tree["parameters/movement/blend_amount"] = 1.0
	elif direction == Vector3.ZERO:
		_anim_tree["parameters/movement/blend_amount"] = 0.0
		
	move_and_slide(direction.normalized() * speed)



func pet_the_dog():
	# TODO
	pass
