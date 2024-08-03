extends Node2D
class_name AlignedPiece

@export var align:bool = false
@export var game_handler:GameHandler = null

var _target_pos : = Vector2()
var active = true

func _ready():
	align = true
	game_handler = get_parent()

func _physics_process(delta):
	if align:
		global_position = Vector2(int(global_position.x/32)*32,
								int(global_position.y/32)*32)
		_target_pos = global_position
		align = false


func _on_area_2d_body_entered(body):
	if body is Player:
		handle_pickup(body)


func handle_pickup(player:Player):
	pass
