extends Node2D
class_name GameHandler

@onready var game_map = %GameMap

func _ready():
	GlobalUtils.start_game_timer()
	GlobalUtils.enemy_dead.connect(on_enemy_death)

func on_enemy_death(type):
	var i = randi_range(0,3)
	var enemy_node = load("res://scenes/enemy/enemy.tscn").instantiate()
	enemy_node.type = (type+1)%4
	get_node("spawn_container/Marker2D"+str(i)).add_child(enemy_node)

func _input(event):
	return
	if event is InputEventMouseButton:
		if event.pressed and event.get_button_index() == MOUSE_BUTTON_LEFT:
			modify_cell(event.position)
		if event.pressed and event.get_button_index() == MOUSE_BUTTON_RIGHT:
			modify_cell(event.position,true)

func modify_cell(scren_pos:Vector2, clear:bool = false):
	var cell_pos := Vector2i(scren_pos/32)
	if clear:
		print("removing", cell_pos,)
		if cell_pos.x <= 0 or cell_pos.y <= 0:
			return
		if cell_pos.x >= int(get_viewport_rect().end.x/32)-1 or cell_pos.y >= int(get_viewport_rect().end.y/32)-1:
			return
		game_map.set_cells_terrain_connect(0,[cell_pos],0,-1)
		$NavigationRegion2D.bake_navigation_polygon()
		return
	print("adding", cell_pos)
	game_map.set_cells_terrain_connect(0,[cell_pos],0,0)
	$NavigationRegion2D.bake_navigation_polygon()


func _on_win_area_body_entered(body):
	if body is Player:
		body.die("congratulations you puzzled the map!")
