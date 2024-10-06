extends Control

@onready var pause_menu = $"."
@onready var pauseBG = $pauseBG

var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

# Handles pause menu
func pauseMenu():
	if paused:
		print_debug("Paused")
		pause_menu.hide()
		pauseBG.hide()
		Engine.time_scale = 1
	else:
		print_debug("unpaused")
		pause_menu.show()
		pauseBG.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_resume_button_pressed() -> void:
	pauseMenu()

func _on_quit_button_pressed() -> void:
	# TO FIX: Exiting then entering the game again starts the game paused
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
