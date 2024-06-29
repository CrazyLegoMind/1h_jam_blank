extends Node2D

func _ready():
	GlobalUtils.start_game_timer()
	GlobalUtils.update_score(0)
	randomize()

func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		body.die("congratulation you escaped!")
