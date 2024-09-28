extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setBoundary()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setBoundary():
	var usedCells = $"tilemap layer 3x3".get_used_cells()
	var boundaryOffsets = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
	for currentCell in usedCells:
		for offset in boundaryOffsets:
			if $"tilemap layer 3x3".get_cell_source_id(currentCell + offset) == -1:
				$"tilemap layer 3x3".set_cell(currentCell + offset,0,Vector2(10,1))
