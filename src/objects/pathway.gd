extends StaticBody

export var spawn_frequency_seconds = 10
export var spawn_limit_simultaneously = 5

var Child = preload("res://src/family/child.tscn")
var OldPerson = preload("res://src/family/old_person.tscn")

onready var _path: Path = get_node("Path")
onready var _path_follow: PathFollow = get_node("Path/PathFollow")
onready var _spawn_timer: Timer = $SpawnTimer

var _current_people_count = 0

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func _add_person(is_old: bool):
	if _current_people_count >= spawn_limit_simultaneously:
		return
	
	var new_person = Child.instance() if is_old else OldPerson.instance()
	# set the position of the new instance to the beginning of the path, otherwise shit happens
	var position = _path.curve.get_point_position(0)
	position.y = 1.5# TODO: remove when Stefan adds model
	new_person.set_translation(position)
	
	_path_follow.add_child(new_person)
	
	_current_people_count += 1
	_spawn_timer.start(spawn_frequency_seconds)
	
	print("spawned %s" % new_person)


func _remove_person(person):
	_current_people_count -= 1
	person.queue_free()
	print("person %s has arrived at goal, removing" % person)


func _on_Goal_body_entered(body):
	_remove_person(body)


func _on_SpawnTimer_timeout():
	# if random generates 1, we spawn an old person, else we spawn a child
	_add_person(rng.randi_range(0, 1) == 1)



