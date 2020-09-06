extends KinematicBody
class_name Dog

export var speed = 10
export var isBarking: bool = false

var direction: Vector3 = Vector3()


onready var _anim_player: AnimationPlayer = $DogAnimated/AnimationPlayer
onready var _bark_area: BarkArea = $BarkArea
onready var _waveParticle: Particles = $BarkArea/SoundWave
onready var _soundSphere: Particles = $BarkArea/SoundSphere
onready var _dust1: Particles = $Particles/Dust1
onready var _dust2: Particles = $Particles/Dust2

func _ready():
	NodeFinder.set_dog(self)

func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("bark"):
		isBarking = true
		_bark_area.bark()
		_anim_player.play("Bark")
		_anim_player.set_speed_scale(1)
		_waveParticle.set_emitting(true)
		_soundSphere.set_emitting(true)


func _process(_delta):
	# reset the direction vector state
	direction = Vector3()
	
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")


func _physics_process(_delta):
	if isBarking:
		direction = Vector3.ZERO
	else:
		if direction != Vector3.ZERO:
			look_at(get_global_transform().origin + direction, Vector3.UP)
			_anim_player.play("RunCycle")
			_dust1.set_emitting(true)
			_dust2.set_emitting(true)
			
			#sync of animation and speed
			_anim_player.set_speed_scale(speed/6.6)
			
		elif direction == Vector3.ZERO:
				_anim_player.play("Idle")
				_anim_player.set_speed_scale(1.5)
				_dust1.set_emitting(false)
				_dust2.set_emitting(false)
				

		
	move_and_slide(direction.normalized() * speed)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Bark":
		isBarking = false
		
