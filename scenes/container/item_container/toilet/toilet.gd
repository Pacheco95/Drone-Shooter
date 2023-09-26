extends ItemContainer



func hit():
	if not super.hit():
		return
	
	var pos = $SpawnPositions/Marker2D.global_position
	open.emit(pos, current_direction)
