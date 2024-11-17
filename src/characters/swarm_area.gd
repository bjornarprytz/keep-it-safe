class_name SwarmArea
extends Area2D

enum TYPE {Moth, Firefly}

@export var type: TYPE
@export var count: int = 5

var radius: float:
	get:
		return $Shape.shape.radius

@onready var moth_spawner : PackedScene = preload("res://characters/moth.tscn")
@onready var firefly_spawner : PackedScene = preload("res://characters/firefly.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(count):
		var fly: Node2D
		match type:
			TYPE.Moth:
				fly = moth_spawner.instantiate() as Node2D
			TYPE.Firefly:
				fly = firefly_spawner.instantiate() as Node2D
		fly.home = self
		add_child(fly)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
