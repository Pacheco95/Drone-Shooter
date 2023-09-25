extends ParentLevel


func _on_area_2d_body_entered(_body: Node2D):
	create_tween().tween_property($Player, "movement_velocity", 0, 0.5)
	var inside_scene := load("res://scenes/levels/inside/inside.tscn")
	TransitionLayer.change_scene(inside_scene)
