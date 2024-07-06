extends Node2D

@onready var game_map = %GameMap

func _ready():
	GlobalUtils.enemy_died.connect(on_enemy_died)
	GlobalUtils.start_game_timer()

func on_enemy_died():
	pass

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


func _on_area_2d_area_entered(area):
	if area.has_method("die"):
		area.die()
