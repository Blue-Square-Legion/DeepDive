extends Area2D

var can_be_picked: bool = false
var canEnter = true
var inRange = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# TO DO
# Add the trigger when all the parts have been repaired to let the player leave

func _process(delta: float) -> void:
	if inRange && canEnter:
		if Input.is_action_just_pressed("part_interaction"):
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Detects if the player has entered or range of the cart
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("player entered")
		inRange = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("player left")
		inRange = false
