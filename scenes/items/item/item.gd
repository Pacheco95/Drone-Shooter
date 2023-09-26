extends Area2D

signal player_collected_item(item_type: String)

const Utils = preload("res://scripts/utils.gd")

@export var rotation_speed := 4
@export var item_colors := {
	"grenade": Color.BLACK,
	"laser": Color.BLACK,
	"health": Color.BLACK,
}
const items = ["grenade", "laser", "laser", "health", "health", "health"]

var item_type: String = Utils.pick_random(items)
var direction := Vector2.ZERO
var distance := randi_range(200, 250)


func _ready():
	modulate = item_colors[item_type]

	var target_pos = position + direction * distance
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	var duration := 1
	tween.tween_property(self, "position", target_pos, duration)
	tween.tween_property(self, "scale", Vector2.ONE, duration).from(Vector2.ZERO)
	



func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D):
	if item_type == "grenade":
		Globals.grenade_amount = min(Globals.grenade_amount + 1, Globals.max_grenade_amount)
	
	if item_type == "laser":
		Globals.laser_amount = min(Globals.laser_amount + 5, Globals.max_laser_amount)

	if item_type == "health":
		Globals.hp_amount = min(Globals.hp_amount + 20, Globals.max_hp_amount)

	queue_free()
