extends ParentLevel


func _on_area_2d_body_entered(_body: Node2D):
	create_tween().tween_property($Player, "movement_velocity", 0, 0.5)
	var outside_scene = load("res://scenes/levels/outside/outside.tscn")
	TransitionLayer.change_scene(outside_scene)
