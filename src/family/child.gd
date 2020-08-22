extends FamilyMember
class_name Child

var _speed: float = 8.0
var _bark_stun_duration: float = 1.1

onready var _stun_timer: Timer = $StunTimer
onready var _anim_player: AnimationPlayer = $BOI/AnimationPlayer
onready var mesh: MeshInstance = $BOI/HumanArmature/Skeleton/Human

onready var texture_BR = load("res://models/Humans/MaleChild/M_ChildTexture_BlackRed.jpg")
onready var texture_B = load("res://models/Humans/MaleChild/M_ChildTexture_Blue.jpg")
onready var texture_BY = load("res://models/Humans/MaleChild/M_ChildTexture_BlueYellow.jpg")
onready var texture_GR = load("res://models/Humans/MaleChild/M_ChildTexture_GreenRed.jpg")
onready var texture_PB = load("res://models/Humans/MaleChild/M_ChildTexture_PinkBrown.jpg")

func _ready():
	randomize()
	var select_texture = [texture_BR, texture_B, texture_BY, texture_GR, texture_PB]
	var randomNumber = randi() % 5
	mesh.get_surface_material(0).albedo_texture = select_texture[randomNumber]

func _physics_process(delta: float):
	if _stun_timer.is_stopped():
		_move_on_path(_speed, delta)
		_anim_player.play("Skip")


func hears_bark():
	_stun_timer.start(_bark_stun_duration)
	_anim_player.play("Stun")
	.hears_bark()
