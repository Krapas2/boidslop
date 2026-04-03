extends Node2D
class_name MosaicShaderRenderer

@export var camera: Camera2D
@export var shader_material: ShaderMaterial
@export var overlap_amount: float
@export var columns: int:
	set(v):
		columns = v
		if is_inside_tree():
			_rebuild_tiles()

@export var rows: int:
	set(v):
		rows = v
		if is_inside_tree():
			_rebuild_tiles()

var _tiles: Array[ColorRect] = []
var _container: Node2D

func _ready() -> void:
	_container = Node2D.new()
	add_child(_container)
	_rebuild_tiles()

func _process(_delta: float) -> void:
	if not camera:
		return
	_fit_tiles_to_camera()

func _rebuild_tiles() -> void:
	for tile in _tiles:
		tile.queue_free()
	_tiles.clear()

	if not shader_material:
		push_warning("MosaicShaderRenderer: no ShaderMaterial assigned.")
		return

	for _i in range(rows * columns):
		var rect := ColorRect.new()
		rect.material = shader_material.duplicate()
		rect.use_parent_material = false
		rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_container.add_child(rect)
		_tiles.append(rect)

func _fit_tiles_to_camera() -> void:
	var viewport      := get_viewport()
	var viewport_size := Vector2(viewport.get_visible_rect().size)
	var zoom          := camera.zoom
	var world_size    := viewport_size / zoom
	var origin        := camera.get_screen_center_position() - world_size / 2.0
	var tile_size     := world_size / Vector2(columns, rows)
	var overlap       := Vector2(overlap_amount, overlap_amount) / zoom

	for row in range(rows):
		for col in range(columns):
			var tile := _tiles[row * columns + col]
			tile.global_position = origin + Vector2(col, row) * tile_size
			tile.size = tile_size + overlap
