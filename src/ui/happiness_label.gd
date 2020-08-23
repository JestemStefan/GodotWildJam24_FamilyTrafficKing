extends Label


func _ready():
	HappinessManager.connect("happiness_updated", self, "_update_display")
	_update_display(0)

func _update_display(happiness_val):
	set_text("Happiness: %d (>= %d needed)" % [happiness_val, HappinessManager.get_happiness_threshold()])
