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

		self.text = "Game Over"
		#get_tree().paused = true
		Engine.time_scale = 0
		$"..".hide()
		$"../../LoseScreen".show()
		
	self.text = "Time left: " + format_string % [4, 0, timer.time_left]
