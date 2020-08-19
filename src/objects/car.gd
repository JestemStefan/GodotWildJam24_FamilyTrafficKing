extends KinematicBody

export var speed = 1

onready var _path : PathFollow = get_parent()

var detected_fams_or_dog: Array = []

func _physics_process(delta):
	if detected_fams_or_dog.size() <= 0:
		_path.set_offset(_path.get_offset() + speed * delta)


func _on_PeopleDetector_body_entered(body):
	# should not be needed but why not 
	if body is Dog or body is FamilyMember:
		detected_fams_or_dog.append(body)
		print("car %s detected %s" % [self, body])


func _on_PeopleDetector_body_exited(body):
	detected_fams_or_dog.erase(body)
	print("car %s undetected %s" % [self, body])
