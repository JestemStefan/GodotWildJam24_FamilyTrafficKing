extends StaticBody

const HAPPINESS_GAIN_ON_GOAL = 30

export var spawn_frequency_seconds = 10
export var spawn_limit_simultaneously = 5

const Child = preload("res://src/family/child.tscn")
const OldPerson = preload("res://src/family/old_person.tscn")

onready var _path: Path = get_node("Path")
onready var _spawn_timer: Timer = $SpawnTimer

var _current_people_count = 0

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func _add_person(is_old: bool):
	if _current_people_count >= spawn_limit_simultaneously:
		return
	
	var new_person = OldPerson.instance() if is_old else Child.instance()
	
	var path_follow = PathFollow.new()
	path_follow.set_translation(_path.curve.get_point_position(0))
	path_follow.add_child(new_person)
	
	_path.add_child(path_follow)
	
	_current_people_count += 1
	_spawn_timer.start(spawn_frequency_seconds)
	
	print("spawned %s is_old=%s " % [new_person, is_old])


func _remove_person(person):
	_current_people_count -= 1
	# delete the PathFollow which is the parent of person
	person.get_parent().queue_free()
	HappinessManager.gain_happiness(HAPPINESS_GAIN_ON_GOAL)
	print("person %s has arrived at goal, removing" % person)


func _on_Goal_body_entered(body):
	_remove_person(body)


func _on_SpawnTimer_timeout():
	# if random generates 1, we spawn an old person, else we spawn a child
	_add_person(rng.randi_range(0, 1) == 1)



