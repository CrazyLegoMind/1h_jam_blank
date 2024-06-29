extends Node

signal enemy_dead()
signal player_spawned(player)
signal player_died

var menu_ui_scene = preload("res://scenes/menus/menu_ui.tscn")
var menu_ui_node:MenuUi = menu_ui_scene.instantiate()
var enemy_killed := 0
var chase_running = false

func _ready():
	player_died.connect(_on_player_died)
	add_child(menu_ui_node)
	menu_ui_node.retry.connect(_on_menu_retry)


func _on_player_died(msg):
	menu_ui_node.show_pause_menu(true)
	menu_ui_node.set_end_text(msg)
 
func _on_menu_retry():
	chase_running = false
	enemy_killed = 0
	menu_ui_node.update_score(0)
	reload_scene()

func change_scene(scene:String):
	get_tree().change_scene_to_file(scene)

func reload_scene():
	get_tree().reload_current_scene()

func add_score(amount:int):
	menu_ui_node.add_score(amount)

func update_score(amount:int):
	menu_ui_node.update_score(amount)

func start_game_timer():
	menu_ui_node.time_flowing = true
