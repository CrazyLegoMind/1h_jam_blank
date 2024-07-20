extends Node2D

@export var fence:Fence = null
@export var power:int = 1

func _ready():
	$Label.text = str(power)

func _on_area_2d_body_entered(body):
	print("got body")
	if body.has_method("battery_amount"):
		
		if body.battery_amount() == power:
			fence.open()
		if body.battery_amount() > power:
			body.die("too many battteries, switch exploded")
		body.consume_batteries(power)
