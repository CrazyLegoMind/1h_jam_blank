extends Node2D

var target = null

func set_target(node):
	target = node

func _process(delta):
	if is_instance_valid(target):
		global_position = target.global_position

func die():
	GlobalUtils.add_score(10+GlobalUtils.dead_enemies)
	GlobalUtils.enemy_died.emit()
	queue_free()

func _on_body_entered(body):
	if body.has_method("grab"):
		body.grab(self)
