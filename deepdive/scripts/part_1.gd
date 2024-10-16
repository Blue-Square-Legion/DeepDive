extends Area2D

var can_be_picked: bool = false

func _ready() -> void:
	self.add_to_group("part")

func sonar_glow() -> void:
	$Sprite2D.material.set_shader_parameter("toggle_outline", true)
	can_be_picked = true
	await get_tree().create_timer(2.0).timeout
	$Sprite2D.material.set_shader_parameter("toggle_outline", false)
	can_be_picked = false

func setup():
	can_be_picked = true
	$Sprite2D.material.set_shader_parameter("toggle_alpha", false)
	$Sprite2D.material.set_shader_parameter("toggle_outline", false)

func left_part():
	can_be_picked = false
	$Sprite2D.material.set_shader_parameter("toggle_alpha", true)
	$Sprite2D.material.set_shader_parameter("toggle_outline", false)
