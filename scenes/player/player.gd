extends CharacterBody2D
class_name Player

var movement_input := Vector2()
var mov_speed = 80
var pickup_state = false
@onready var animation_player_node:AnimationPlayer = $AnimationPlayer
@onready var tile_sprite = %TileSprite

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

func die(msg = ""):
	GlobalUtils.player_died.emit(msg)
	queue_free()

func pickup(state:bool):
	pickup_state = state
	tile_sprite.visible = pickup_state
	if state:
		$CollisionShape2D.scale = Vector2(1.7,1.7)
	else:
		$CollisionShape2D.scale = Vector2(1,1)
