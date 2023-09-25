extends Node2D
class_name ParentLevel

const laser_scene := preload("res://scenes/projectiles/laser/laser.tscn")
const grenade_scene := preload("res://scenes/projectiles/grenade/grenade.tscn")

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

var initial_camera_zoom := Vector2.ZERO

func _ready():
	initial_camera_zoom = $Player/Camera2D.zoom


func _on_player_player_threw_grenade(pos, direction):
	var grenade := grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	# $UI.update_grenade_text()


func _on_player_player_shot_laser(pos, direction):
	var laser = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	# $UI.update_laser_text()


func _on_house_player_entered_house():
	var tween := get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2.ONE, 1)


func _on_house_player_exited_house():
	var tween := get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", initial_camera_zoom, 1)

func _on_player_collected_item(item: String):
	print(item, " ", typeof(item), " ", TYPE_STRING)

	if item == "grenade":
		Globals.grenade_amount = min(Globals.grenade_amount + 1, Globals.max_grenade_amount)
	
	if item == "laser":
		Globals.laser_amount = min(Globals.laser_amount + 5, Globals.max_laser_amount)

	if item == "health":
		Globals.hp_amount = min(Globals.hp_amount + 20, Globals.max_hp_amount)
