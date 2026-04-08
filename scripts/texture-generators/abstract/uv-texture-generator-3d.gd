@tool
class_name UvTextureGenerator3D
extends ImageTexture3D

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
	
	var images: Array[Image] = []
	for z: int in resolution:
		var img: Image = Image.create_empty(resolution, resolution, false, Image.FORMAT_RGBA8)
		for y: int in resolution:
			for x: int in resolution:
				var uv: Vector3 = Vector3(x,y,z)/resolution
				var color: Color = _pixel_from_uv(uv)
				img.set_pixel(x, y, color)
		images.append(img)
	
	create(Image.FORMAT_RGBA8, resolution, resolution, resolution, false, images)
	emit_changed()

func _setup() -> void:
	pass

func _should_generate() -> bool:
	push_error("_should_generate() must be implemented")
	return false

func _pixel_from_uv(_uv: Vector3) -> Color:
	push_error("_pixel_from_uv(uv: Vector3) must be implemented")
	return Color.BLACK
