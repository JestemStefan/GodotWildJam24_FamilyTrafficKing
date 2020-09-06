extends SpawnerPath
class_name CarPath

signal spawned_car

const Car = preload("res://src/objects/car.tscn")


func _get_new_spawn():
	return Car.instance()


func _post_spawn(new_car):
	emit_signal("spawned_car", new_car)
	print("spawned %s car " % [new_car])
