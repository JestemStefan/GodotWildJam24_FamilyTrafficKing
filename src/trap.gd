extends KinematicBody

export var speed = 10

var _movement_direction = Vector3(-1,0,0)

func _physics_process(delta):
	var collision = move_and_collide(_movement_direction * speed * delta)
	if collision:
		print("boom")
		queue_free()
