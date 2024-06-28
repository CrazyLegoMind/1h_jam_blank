extends CanvasLayer
class_name MenuUi


var _displayed_score := 0
var _time_elapsed :float = 0.0
##variable to start/stop the timer
var time_flowing:bool = false:
	set(value):
		time_flowing = value

signal retry

func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		show_pause_menu(true)

func _on_retry_pressed():
	_displayed_score= 0
	_time_elapsed= 0.0
	show_pause_menu(false)
	retry.emit()

func _process(delta):
	if time_flowing and not get_tree().paused:
		_time_elapsed += delta
	update_time_elapsed()

func update_score(score:int):
	_displayed_score = score
	%ScoreValue.text = str(_displayed_score)

func add_score(score:int):
	_displayed_score += score
	%ScoreValue.text = str(_displayed_score)

func show_pause_menu(state:bool):
	get_tree().paused = state
	$PauseMenu.set_visible(state)

func update_time_elapsed():
	var temp_time:float = _time_elapsed
	var days:int = temp_time/float(60*60*24)
	temp_time -= days*60*60*24
	var hours:int = (temp_time)/float(60*60)
	temp_time -= hours*60*60
	var minutes:int = (temp_time)/float(60)
	temp_time -= minutes*60
	%TimeValue.text = "%02d:%02d:%02d:%05.2f" % [days,hours,minutes,temp_time]
