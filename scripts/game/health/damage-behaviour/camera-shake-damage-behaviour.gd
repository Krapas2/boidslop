extends DamageBehaviour
class_name CameraShakeDamageBehaviour

@export var intensity: float
@export var length: float

@onready var camemera_controller: CameraController = CameraController.instance

const PLAYER_DAMAGE_CAMERA_SHAKE_KEY: String = "PLAYER_DAMAGE_CAMERA_SHAKE"

func damage_behaviour() -> void:
	var elapsed: float = 0.0

	while elapsed < length:
		camemera_controller.additional_offsets[PLAYER_DAMAGE_CAMERA_SHAKE_KEY] = Vector2(
			randf_range(-intensity, intensity),
			randf_range(-intensity, intensity)
		)

		elapsed += get_process_delta_time()
		await get_tree().process_frame

	camemera_controller.additional_offsets.erase(PLAYER_DAMAGE_CAMERA_SHAKE_KEY)
