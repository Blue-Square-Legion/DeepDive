extends CanvasLayer


func _on_retry_button_pressed() -> void:
	print_debug("restart pressed")
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	print_debug("quit pressed")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
