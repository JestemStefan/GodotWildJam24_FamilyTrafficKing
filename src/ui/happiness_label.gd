extends Label


func _ready():
	HappinessManager.connect("happiness_updated", self, "_update_display")
	

func _update_display(happiness_val):
	set_text("Happiness: " + str(happiness_val))
