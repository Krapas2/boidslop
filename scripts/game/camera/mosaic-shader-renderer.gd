extends Node
class_name MosaicShaderRenderer

@export var shader_material: ShaderMaterial
@export var overlap_amount: float
@export var padding: float
@export var z_index: int
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

@onready var camera: Camera2D = get_parent()

func _ready() -> void:
	_rebuild_tiles()

func _process(_delta: float) -> void:
	if not camera:
		return
	_fit_tiles_to_camera()

func _rebuild_tiles() -> void:
	for tile: ColorRect in _tiles:
		tile.queue_free()
	_tiles.clear()

	if not shader_material:
		push_warning("MosaicShaderRenderer: no ShaderMaterial assigned.")
		return

	for _i: int in range(rows * columns):
		var rect: ColorRect = ColorRect.new()
		rect.material = shader_material.duplicate()
		rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		rect.z_index = z_index
		add_child(rect)
		_tiles.append(rect)

func _fit_tiles_to_camera() -> void:
	var viewport: Viewport = get_viewport()
	var viewport_size: Vector2 = (
		Vector2(viewport.get_visible_rect().size) +
		Vector2(padding, padding)
	)
	var zoom: Vector2 = camera.zoom
	var world_size: Vector2 = viewport_size / zoom
	var origin: Vector2 = camera.get_screen_center_position() - world_size / 2.0
	var tile_size: Vector2 = world_size / Vector2(columns, rows)
	var overlap: Vector2 = Vector2(overlap_amount, overlap_amount) / zoom

	for row: int in range(rows):
		for col: int in range(columns):
			var tile: ColorRect = _tiles[row * columns + col]
			tile.global_position = origin + Vector2(col, row) * tile_size
			tile.size = tile_size + overlap
