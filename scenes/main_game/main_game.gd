extends Node2D

func _ready():
	GlobalUtils.enemy_dead.connect(on_enemy_death)

func on_enemy_death(type):
	var i = randi_range(0,3)
	var enemy_node = load("res://scenes/enemy/enemy.tscn").instantiate()
	enemy_node.type = (type+1)%4
	get_node("spawn_container/Marker2D"+str(i)).add_child(enemy_node)
