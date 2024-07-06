extends CharacterBody2D


var direction := Vector2()
var following := false
var player = null
var mov_speed = 100
var _elapsed_time: = 0.0
@onready var nav_agent:NavigationAgent2D = %NavigationAgent2D


func _ready():
	$AnimationPlayer.play("idle")
	GlobalUtils.player_spawned.connect(_on_player_spawned)


func _physics_process(delta):
	var velocity_dir = Vector2()
	player = GlobalUtils.player
	direction = Vector2()
	if following and is_instance_valid(player) and nav_agent.is_target_reachable():
		nav_agent.target_position = player.global_position
		direction =(nav_agent.get_next_path_position()-global_position).normalized()
		velocity = direction*mov_speed
		$AnimationPlayer.play("walk")
	if velocity.length() > mov_speed*0.5:
		$SpriteContainer.scale.x = -sign(velocity.x)
	move_and_slide()
	if velocity.length() > mov_speed*0.5:
		_elapsed_time += delta
		if _elapsed_time >= 1:
			_elapsed_time = 0
			GlobalUtils.add_score(1)


func _on_player_spawned(pl):
	print("got_player")
	player = pl

func die():
	GlobalUtils.add_score(10)
	queue_free()

func _on_area_2d_body_entered(body):
	if following:
		if body.has_method("die"):
			GlobalUtils.add_score(-100)
			body.die("you didn't escape in time!")
			return
	var i = randi()%10
	var check = 0 if GlobalUtils.enemy_killed >= 10 else 10 - GlobalUtils.enemy_killed
	print(i, " ",check)
	if i > check:
		$AnimationPlayer.play("transform")
		GlobalUtils.chase_running = true
	else:
		GlobalUtils.enemy_killed += 1
		die()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "transform":
		following = true
		
