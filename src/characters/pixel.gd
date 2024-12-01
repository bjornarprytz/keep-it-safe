class_name Pixel
extends Area2D

const SPEED: float = 200.0

@export var pixel_boundary: float = 25.0 # Radius of the pixel boundary.
@export var moth_tolerance: int = 10 # How many moths before game over

var landed_moths: int = 0

@onready var pixel: Sprite2D = %Pixel
@onready var light: PointLight2D = %Light

func _process(_delta: float) -> void:
	# Move the pixel toward the mouse position. Bounded by the pixel_boundary.

	var target_position = get_global_mouse_position()
	var direction = target_position - global_position
	var distance = min(direction.length(), pixel_boundary)

	if distance > 0:
		direction = direction.normalized()
		pixel.position = direction * distance
	
	_update_light_intensity()


func moth_landed(moth: Moth) -> void:
	landed_moths += 1
	if landed_moths == moth_tolerance:
		Events.gameOver.emit(false)
	_update_light_intensity()
	
	await Utility.shake(pixel, .2, 3.0, Vector2.ZERO).finished

func _update_light_intensity() -> void:
	var elevation = abs((pixel.position.y - pixel_boundary) / (pixel_boundary * 2))
	var clutter = 1.0 - min((landed_moths / float(moth_tolerance)), 1.0)
	
	var strength = elevation * clutter
	
	light.scale = Vector2.ONE * strength
