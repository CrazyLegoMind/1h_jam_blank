extends Node

signal enemy_died()
signal player_spawned(player)
signal player_died

var menu_ui_scene = preload("res://scenes/menus/menu_ui.tscn")
var menu_ui_node:MenuUi = menu_ui_scene.instantiate()
var player = null
var dead_enemies = 0

func _ready():
	player_died.connect(_on_player_died)
	enemy_died.connect(_on_enemy_died)
	player_spawned.connect(_on_player_spawned)
	add_child(menu_ui_node)
	menu_ui_node.retry.connect(_on_menu_retry)

func _process(delta):
	if is_instance_valid(player):
		menu_ui_node.set_tilt(player.tilt)

func _on_player_died(txt ="end"):
	menu_ui_node.show_pause_menu(true)
	menu_ui_node.set_end_text(txt)

func _on_enemy_dead():
	pass

func _on_enemy_died():
	dead_enemies += 1
	if dead_enemies >= 8:
		menu_ui_node.set_end_text("good job!")
		menu_ui_node.show_pause_menu(true)

func _on_player_spawned(pl):
	player = pl

func _on_menu_retry():
	dead_enemies = 0
	menu_ui_node.update_score(0)
	reload_scene()

func change_scene(scene:String):
	get_tree().change_scene_to_file(scene)

func reload_scene():
	get_tree().reload_current_scene()

func add_score(amount:int):
	menu_ui_node.add_score(amount)

func start_game_timer():
	menu_ui_node.time_flowing = true
