extends CanvasLayer

@export var laser_text: Label
@export var laser_ui_texture: TextureRect

@export var grenade_text: Label
@export var grenade_ui_texture: TextureRect

@export var hp_ui_texture: TextureProgressBar

@export var ammo_gradient: Gradient


func update_texture_color(tex: TextureRect, label: Label, amount: int, max_amount: int):
	var color = ammo_gradient.sample(float(amount) / max_amount)
	tex.modulate = color
	label.modulate = color
	label.text = str(amount)

func _ready():
	update_laser_text()
	Globals.connect("laser_changed", update_laser_text)

	update_grenade_text()
	Globals.connect("grenade_changed", update_grenade_text)

	update_hp_progress_bar()
	Globals.connect("hp_changed", update_hp_progress_bar)

func update_laser_text():
	update_texture_color(laser_ui_texture, laser_text, Globals.laser_amount, Globals.max_laser_amount)

func update_grenade_text():
	update_texture_color(grenade_ui_texture, grenade_text, Globals.grenade_amount, Globals.max_grenade_amount)

func update_hp_progress_bar():
	hp_ui_texture.value = Globals.hp_amount
