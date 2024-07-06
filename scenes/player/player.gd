extends CharacterBody2D

var movement_input := Vector2()
var mov_speed = 80
var locked = false
var tilt = 0
var tilt_force := 0.0
var grabbing := 0.0
@onready var body = %body
@onready var animation_player_node:AnimationPlayer = $AnimationPlayer
@onready var grab_position = %GrabPosition

func _ready():
	GlobalUtils.player_spawned.emit(self)
	GlobalUtils.enemy_died.connect(on_enemy_died)

func on_enemy_died():
	tilt_force = 0
	grabbing = 0.0
	body.rotation_degrees = body.rotation_degrees*0.5
	$AnimationPlayer.stop()
	locked = true
	$AnimationPlayer.stop()
	animation_player_node.speed_scale =1
	$AnimationPlayer.play_backwards("grab")
	await $AnimationPlayer.animation_finished
	locked = false

func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		GlobalUtils.start_game_timer()

func _physics_process(delta):
	tilt = body.rotation_degrees
	if Input.is_action_pressed("tilt_l"):
		tilt_force = -40
	if Input.is_action_pressed("tilt_r"):
		tilt_force = 40
	tilt_force = lerp(tilt_force,0.0,delta)
	body.rotation_degrees = body.rotation_degrees + tilt_force*delta +delta*(
								body.rotation_degrees*0.7+
								body.rotation_degrees*grabbing)
	body.rotation_degrees = clamp(body.rotation_degrees,-60,60)
	if body.rotation_degrees > 59 or body.rotation_degrees <-59:
		die()
	if locked:
		return
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
		animation_player_node.speed_scale = 4
		anim = "walk_h"
	$AnimationPlayer.play(anim)


func die():
	GlobalUtils.player_died.emit()
	queue_free()

func grab(node):
	$AnimationPlayer.stop()
	locked = true
	$AnimationPlayer.stop()
	animation_player_node.speed_scale =1
	$AnimationPlayer.play("grab")
	await $AnimationPlayer.animation_finished
	node.set_target(grab_position)
	locked = false
	body.rotation_degrees = body.rotation_degrees*0.6
	grabbing += 0.6 + GlobalUtils.dead_enemies*0.05
	print(grabbing)
