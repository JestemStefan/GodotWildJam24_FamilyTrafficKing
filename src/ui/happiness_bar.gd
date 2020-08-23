extends ProgressBar

func _ready():
	self.set_max(HappinessManager.get_happiness_threshold())
	HappinessManager.connect("happiness_updated", self, "_update_display")

func _update_display(new_happiness_value):
	self.set_value(new_happiness_value)
