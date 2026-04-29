@tool
class_name UvTextureGenerator2D
extends ImageTexture

@export_range(2, 256) var resolution: int = 64:
	set(v):
		resolution = v
		_generate()

@export_tool_button("Generate") var generate_button: Callable = _generate

func _init() -> void:
	_generate()

func _generate() -> void:
	if (
		!_should_generate() ||
		!resolution
	):
		return
		
	_setup()
	
	var generated_image: Image = Image.create_empty(resolution, resolution, false, Image.FORMAT_RGBA8)
	for y: int in resolution:
		for x: int in resolution:
			var uv: Vector2 = Vector2(x,y)/resolution
			var color: Color = _pixel_from_uv(uv)
			generated_image.set_pixel(x, y, color)
	
	set_image(generated_image)
	emit_changed()

func _setup() -> void:
	pass

func _should_generate() -> bool:
	push_error("_should_generate() must be implemented")
	return false

func _pixel_from_uv(_uv: Vector2) -> Color:
	push_error("_pixel_from_uv(uv: Vector2) must be implemented")
	return Color.BLACK
