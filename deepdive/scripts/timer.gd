extends Label

@onready var timer = $GameTimer

var format_string = "%*.*f"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	timer.start()


# Called every frame. 'deltas' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.time_left <= 0:
		# TODO this should instead bring up the game over UI with options
		self.text = "Game Over"
		get_tree().paused = true
		await get_tree().create_timer(3.0).timeout
		get_tree().reload_current_scene()
		
	self.text = "Time left: " + format_string % [4, 0, timer.time_left]
