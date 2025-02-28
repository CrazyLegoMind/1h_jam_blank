extends Node

signal enemy_dead()
signal player_spawned(player)
signal player_died

var menu_ui_scene = preload("res://scenes/menus/menu_ui.tscn")
var menu_ui_node:MenuUi = menu_ui_scene.instantiate()
var player = null

func _ready():
	player_died.connect(_on_player_died)
	enemy_dead.connect(_on_enemy_dead)
	player_spawned.connect(_on_player_spawned)
	add_child(menu_ui_node)
	menu_ui_node.retry.connect(_on_menu_retry)


func _on_player_died(txt ="end"):
	menu_ui_node.show_pause_menu(true)
	menu_ui_node.set_end_text(txt)

func _on_enemy_dead():
	pass

func _on_player_spawned(pl):
	player = pl

func _on_menu_retry():
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
