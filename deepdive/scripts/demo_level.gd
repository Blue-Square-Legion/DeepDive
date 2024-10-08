extends Node2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setBoundary()

func setBoundary():
	var usedCells = tile_map_layer.get_used_cells()
	var boundaryOffsets = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
	for cell in usedCells:
		for offset in boundaryOffsets:
			if tile_map_layer.get_cell_source_id(cell + offset) == -1:
				tile_map_layer.set_cell(cell + offset, 0, Vector2(1, 0))
