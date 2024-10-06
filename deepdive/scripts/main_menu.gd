extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Handles main menu buttons
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/isometric 2d testing.tscn")

func _on_options_button_pressed() -> void:
	# TODO implement sound options and menu
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
