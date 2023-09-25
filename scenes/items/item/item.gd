extends Area2D

signal player_collected_item(item_type: String)

@export var rotation_speed := 4
@export var item_colors := {
	"grenade": Color.BLACK,
	"laser": Color.BLACK,
	"health": Color.BLACK
}

var item_type: String = item_colors.keys()[randi() % len(item_colors)]


func _ready():
	modulate = item_colors[item_type]

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D):
	player_collected_item.emit(item_type)
	queue_free()
