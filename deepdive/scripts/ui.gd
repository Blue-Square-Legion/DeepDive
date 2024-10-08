extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../PlayerArea2D".connect("set_part_texture", _on_set_texture)
	$"../PlayerArea2D".connect("set_drop_part", _on_drop_part)

func _on_set_texture(part: Area2D):
	var sprite = part.get_node("Sprite2D") as Sprite2D
	if sprite:
		$TextureRect.texture = sprite.texture
		
func _on_drop_part():
	$TextureRect.texture = null
