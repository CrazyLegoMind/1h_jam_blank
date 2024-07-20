class_name Battery
extends Node2D

var _pickup := false

func _on_pickup_area_body_entered(body):
	if _pickup:
		return
	if body.has_method("pickup_battery"):
		_pickup = true
		body.pickup_battery(self)
		
