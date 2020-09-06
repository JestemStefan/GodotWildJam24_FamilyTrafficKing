extends SpawnerPath

signal spawned_person
signal person_reached_goal

const Child = preload("res://src/family/child.tscn")
const OldPerson = preload("res://src/family/old_person.tscn")


func _get_new_spawn():
	# if random generates 1, we spawn an old person, else we spawn a child
	var is_old = GameManager.get_rng().randi_range(0, 1) == 1
	return OldPerson.instance() if is_old else Child.instance()


func _post_spawn(new_person):
	emit_signal("spawned_person", new_person)
	print("spawned person %s " % new_person)


func _post_despawn():
	emit_signal("person_reached_goal")
