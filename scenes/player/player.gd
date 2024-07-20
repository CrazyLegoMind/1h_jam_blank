extends CharacterBody2D

var movement_input := Vector2()
var mov_speed = 80
var batteries = 0
@onready var animation_player_node:AnimationPlayer = $AnimationPlayer
@onready var battery_container = %BatteryContainer

func _ready():
	GlobalUtils.player_spawned.emit(self)

func _input(event):
	pass

func _physics_process(delta):
	movement_input = Vector2()
	movement_input = Input.get_vector("move_left","move_right","move_up","move_down")
	
	
	velocity = mov_speed*movement_input
	move_and_slide()
	var anim = "RESET"
	animation_player_node.speed_scale = 4
	if velocity.y != 0:
		anim = "walk_v"
		animation_player_node.speed_scale *= movement_input.y
	if velocity.x != 0 :
		if sign(movement_input.x) == -1:
			$SpriteContainer.scale.x = -1
		else:
			$SpriteContainer.scale.x = 1
		animation_player_node.speed_scale = 4
		anim = "walk_h"
	$AnimationPlayer.play(anim)

func die(msg=""):
	GlobalUtils.player_died.emit(msg)
	queue_free()

func battery_amount()->int:
	return batteries

func pickup_battery(battery):
	batteries += 1
	battery.call_deferred("reparent",$BatteryContainer,false)
	battery.position = Vector2(0, (batteries-1)*9)
	battery.rotation_degrees = 90

func consume_batteries(amt:int):
	if amt > batteries:
		die("you got electrocuted")
		return
	batteries -= amt
	var childs = battery_container.get_children()
	for i in range(amt):
		childs[i].queue_free()
