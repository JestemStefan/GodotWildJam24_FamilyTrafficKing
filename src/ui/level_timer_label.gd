extends Label

var _minutes = 0
var _seconds = 0


func _ready():
	var total_time_seconds = TimerManager.get_remaining_time()
	if total_time_seconds > 60:
		_minutes = total_time_seconds / 60
		_seconds = total_time_seconds - _minutes * 60
	else:
		_minutes = 0
		_seconds = total_time_seconds
	TimerManager.get_timer().connect("timeout", self, "_update_time")
	_update_display()


func _update_time():
	if _seconds > 0:
		_seconds -= 1
	else:
		if _minutes > 0:
			_minutes -= 1
			_seconds = 59
		else:
			set_text("Time's up!")
	_update_display()


func _update_display():
	set_text("Time remaining: " + str(_minutes).pad_zeros(2) 
	+ ":" + str(_seconds).pad_zeros(2))
