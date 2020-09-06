extends Path
class_name SpawnerPath


export var spawn_frequency_seconds = 10
export var spawn_limit_simultaneously = 5

onready var _spawn_timer: Timer = $SpawnTimer

var _current_spawn_count = 0

### Interface ###
func _get_new_spawn():
	pass


func _post_spawn(spawnee: Node):
	pass


func _post_despawn():
	pass
#################

func _ready():
	$SpawnTimer.connect("timeout", self, "_on_SpawnTimer_timeout")
	$Goal.connect("body_entered", self, "_on_Goal_body_entered")
	var points = curve.get_baked_points()
	print(points)

func _spawn():
	if _current_spawn_count >= spawn_limit_simultaneously:
		return 

	var spawnee = _get_new_spawn()

	var path_follow = PathFollow.new()
	path_follow.add_child(spawnee)
	
	add_child(path_follow)
	
	_current_spawn_count += 1
	_spawn_timer.start(spawn_frequency_seconds)
	
	_post_spawn(spawnee)


func _despawn(spawnee):
	_current_spawn_count -= 1
	_post_despawn()
	# delete the PathFollow which is the parent of spawnee	
	spawnee.get_parent().queue_free()


func _on_Goal_body_entered(body):
	_despawn(body)


func _on_SpawnTimer_timeout():
	_spawn()
