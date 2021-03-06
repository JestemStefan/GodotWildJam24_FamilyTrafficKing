extends Node

onready var animplayer: AnimationPlayer = $Paws/AnimationPlayer
onready var paws:Control = $Paws

var randRot = 0

func _ready():
	animplayer.play("TitleScrren")
	randomize()
	randRot = rand_range(-3, 3)
	
	
func _on_Start_pressed():
	GameManager.load_first_level()


func _on_Quit_pressed():
	get_tree().quit()


func _on_HSlider_value_changed(value):
	Settings.masterVolume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))


func _on_AnimationPlayer_animation_finished(anim_name):
	randomize()
	randRot = rand_range(-3, 3)
	paws.set_rotation(randRot)
	animplayer.play("TitleScrren")

