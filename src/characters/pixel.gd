class_name Pixel
extends Area2D

const SPEED: float = 200.0

@export var pixel_boundary: float = 25.0 # Radius of the pixel boundary.
@export var moth_tolerance: int = 10 # Distance from the moth to trigger landing.

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
	_update_light_intensity()
	## TODO: Add black squares to the pixel to represent landed moths.

func _update_light_intensity() -> void:
	light.scale = Vector2.ONE * (pixel.position.y - pixel_boundary) / (pixel_boundary * 2) - (Vector2.ONE * (landed_moths / float(moth_tolerance)))
