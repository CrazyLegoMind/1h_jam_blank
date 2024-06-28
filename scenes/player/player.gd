extends CharacterBody2D

var movement_input := Vector2()
var mov_speed = 80
@onready var animation_player_node:AnimationPlayer = $AnimationPlayer

func _ready():
	GlobalUtils.player_spawned.emit(self)

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		GlobalUtils.add_score(10)
		die()
	if Input.is_action_just_pressed("ui_up"):
		GlobalUtils.start_game_timer()

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
		$SpriteContainer.scale.x = sign(movement_input.x)
		animation_player_node.speed_scale = 4
		anim = "walk_h"
	$AnimationPlayer.play(anim)

func die():
	GlobalUtils.player_died.emit()
	queue_free()
