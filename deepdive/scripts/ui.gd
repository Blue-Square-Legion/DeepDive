extends CanvasLayer

@onready var holy_diver: Player = %HolyDiver
@onready var texture_rect: TextureRect = %TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	holy_diver.connect("set_part_texture", _on_set_texture)
	holy_diver.connect("set_drop_part", _on_drop_part)

func _on_set_texture(part: Area2D):
	var sprite = part.get_node("Sprite2D") as Sprite2D
	if sprite:
		texture_rect.texture = sprite.texture
		
func _on_drop_part():
	texture_rect.texture = null
