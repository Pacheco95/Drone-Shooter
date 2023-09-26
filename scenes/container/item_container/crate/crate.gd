extends ItemContainer

const Utils = preload("res://scripts/utils.gd")

func hit():
	if not super.hit():
		return
	
	for i in range(5):
		var pos = Utils.pick_random($SpawnPositions.get_children()).global_position
		open.emit(pos, current_direction)


