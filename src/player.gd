class_name Player
extends CharacterBody2D
const back_sprite = preload("res://assets/character-back.png")
const normal = preload("res://assets/character-normal.png")

@onready var pixel: Pixel = %Pixel
@onready var sprite: Sprite2D = %Sprite

const SPEED = 200.0

var stopped: bool:
	set(value):
		stopped = value
		if stopped:
			sprite.texture = back_sprite
			move_child(pixel, 0)
		else:
			sprite.texture = normal
			move_child(pixel, 2)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (stopped):
		return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
