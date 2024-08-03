@tool
extends AlignedPiece

func handle_pickup(player:Player):
	if not active:
		return
	if player.pickup_state:
		return
	active = false
	game_handler.modify_cell(_target_pos,true)
	player.pickup(true)
	queue_free()
