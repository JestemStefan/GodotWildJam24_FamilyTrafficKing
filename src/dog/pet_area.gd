extends Area

signal pet

const HAPPINESS_FREQUENCY = 2 # seconds


onready var _timer: Timer = $PetTimer
onready var _pet_label = $PetLabel
onready var _heart_particles: Particles = $HeartParticles

var detected_fams = []


func _on_PetArea_body_entered(body):
	if body is FamilyMember:
		detected_fams.append(body)
		if _timer.is_stopped():
			_timer.start(HAPPINESS_FREQUENCY)


func _on_PetArea_body_exited(body):
	detected_fams.erase(body)
	if detected_fams.size() == 0:
		_timer.stop()


func _on_PetTimer_timeout():
	if detected_fams.size() > 0:
		emit_signal("pet")
		_heart_particles.set_emitting(true)
		_pet_label.display(get_global_transform().origin, HappinessManager.HAPPINESS_GAIN_PET)
