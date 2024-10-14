extends CanvasLayer

@onready var holy_diver: Player = %HolyDiver
@onready var texture_rect: TextureRect = %TextureRect
@onready var machine_ui: CanvasLayer = %MachineUI

signal current_part(part: TextureRect)
signal remove_part()
signal clear_part_array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	holy_diver.connect("set_part_texture", _on_set_texture)
	holy_diver.connect("set_drop_part", _on_drop_part)
	machine_ui.connect("on_success", _on_success)

func _on_set_texture(part: Area2D):
	var sprite = part.get_node("Sprite2D") as Sprite2D
	if sprite:
		texture_rect.texture = sprite.texture
		current_part.emit(texture_rect)
		
func _on_drop_part():
	remove_part.emit()
	texture_rect.texture = null

func _on_success():
	clear_part_array.emit()
	texture_rect.texture = null
