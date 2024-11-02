class_name Pixel
extends Node2D

const SPEED: float = 200.0

@export var pixel_boundary: float = 25.0 # Radius of the pixel boundary.

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
	
	light.scale = Vector2.ONE * (pixel.position.y - pixel_boundary) / (pixel_boundary * 2)
