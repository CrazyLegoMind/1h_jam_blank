extends CharacterBody2D

var player = null
var mov_speed = 60
var direction := Vector2()
var following := false
@onready var nav_agent:NavigationAgent2D = %NavigationAgent2D

func _physics_process(delta):
	player = GlobalUtils.player
	direction = Vector2()
	if following and is_instance_valid(player) and nav_agent.is_target_reachable():
		nav_agent.target_position = player.global_position
		direction =(nav_agent.get_next_path_position()-global_position).normalized()
	velocity = direction*mov_speed
	move_and_slide()

func die():
	queue_free()


func _on_timer_timeout():
	following = true
