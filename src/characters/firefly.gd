class_name Firefly
extends Node2D

@export var home: SwarmArea
@export var speed: float = 20

@onready var body: AnimatedSprite2D = %Fly
@onready var glow: PointLight2D = %Glow

var _target_glow_scale: float = 0.0
var _direction: Vector2 = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body.frame = randi_range(0,3)


func _physics_process(delta: float) -> void:
	position += _direction * speed * delta

	glow.scale = lerp(glow.scale, Vector2.ONE * _target_glow_scale, .1)

	_target_glow_scale = randf_range(.1, .69)
	

func _course_correct() -> void:
	var new_direction: Vector2 = _direction
	if (body.global_position - home.global_position).length() > home.radius:
		## Change direction to a random direction within 30 degrees of the direction to the home.
		new_direction = body.global_position.direction_to(home.global_position).rotated(deg_to_rad(randf_range(-15, 15)))
	else:
		new_direction = _direction.rotated(randf_range(-180, 180))

	var tween = create_tween()
	tween.tween_property(self, "_direction", new_direction, .69)
