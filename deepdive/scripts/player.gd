class_name Player extends CharacterBody2D

var speed := 120.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down") 
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func _on_sonar_area_entered(area: Area2D) -> void:
	if area is Part:
		print("works!")
