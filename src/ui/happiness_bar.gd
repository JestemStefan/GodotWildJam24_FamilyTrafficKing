extends ProgressBar

func _ready():
	HappinessManager.connect("happiness_updated", self, "_update_display")

func _update_display(new_happiness_value):
	self.value = new_happiness_value
