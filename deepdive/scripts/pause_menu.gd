extends CanvasLayer

@onready var pause_menu = $"."
@onready var pauseBG = $pauseBG
@onready var pause_buttons = $Pause
@onready var control_text = $"Controls text"
@onready var options_menu = $Options

var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

# Handles pause menu
func pauseMenu():
	if paused:	
		print_debug("unpaused")
		pause_menu.hide()
		pauseBG.hide()
		Engine.time_scale = 1
	else:
		print_debug("paused")
		pause_menu.show()
		pauseBG.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_resume_button_pressed() -> void:
	pauseMenu()

func _on_quit_button_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_controls_button_pressed() -> void:
	pause_buttons.hide()
	control_text.show()
	
func _on_back_button_pressed() -> void:
	control_text.hide()
	pause_buttons.show()

func _on_options_button_pressed() -> void:
	pause_buttons.hide()
	options_menu.show()
	
func _on_op_back_button_pressed() -> void:
	pause_buttons.show()
	options_menu.hide()
