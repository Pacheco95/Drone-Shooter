extends CanvasLayer

@export var laser_text: Label
@export var grenade_text: Label
@export var laser_ui_texture: TextureRect
@export var grenade_ui_texture: TextureRect

@export var ammo_gradient: Gradient

func update_texture_color(tex: TextureRect, label: Label, amount: int, max: int):
	var color = ammo_gradient.sample(float(amount) / max)
	tex.modulate = color
	label.modulate = color
	label.text = str(amount)

func _ready():
	update_laser_text()
	update_grenade_text()

func update_laser_text():
	update_texture_color(laser_ui_texture, laser_text, Globals.laser_amount, Globals.max_laser_amount)

func update_grenade_text():
	update_texture_color(grenade_ui_texture, grenade_text, Globals.grenade_amount, Globals.max_grenade_amount)
