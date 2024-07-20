class_name Fence
extends Node2D

func open():
	$Sprite2D.frame = 1
	$Area2D/CollisionShape2D.call_deferred("set_disabled",true)
