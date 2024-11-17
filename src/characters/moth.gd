class_name Moth
extends Node2D

enum State {IDLE, FLYING}

@export var home: SwarmArea
@export var speed: float = 100

var state: State = State.IDLE

@onready var body: Area2D = %Fly
@onready var awareness: Area2D = %Awareness

var _direction: Vector2 = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
var _target: Pixel = null

func _course_correct() -> void:
	var new_direction: Vector2 = _direction
	match state:
		State.FLYING:
			## Change direction to a random direction within 30 degrees of the direction to the target.
			new_direction = _target.global_position.direction_to(body.global_position).rotated(randf_range(-15, 15))
		_:
			if (body.global_position - home.global_position).length() > home.radius:
				## Change direction to a random direction within 30 degrees of the direction to the home.
				new_direction = home.global_position.direction_to(body.global_position).rotated(randf_range(-15, 15))
	var tween = create_tween()
	tween.tween_property(self, "_direction", new_direction, .69)

func _physics_process(delta: float) -> void:
	position += _direction * speed * delta

func _on_fly_area_entered(area: Area2D) -> void:
	if area == _target:
		_target.moth_landed(self)
		queue_free()

func _on_awareness_area_entered(area: Area2D) -> void:
	if area.owner is Pixel:
		state = State.FLYING
		_target = area
