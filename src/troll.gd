class_name Troll
extends Area2D


@onready var sprite: Sprite2D = %Sprite
@onready var mouth: AudioStreamPlayer2D = %Mouth

enum TrollMood {
	Hmm,
	Take,
	Who
}

var sounds: Dictionary = {
	TrollMood.Who: [
		preload("res://assets/audio/effects/KeepitsafeTROLL7.wav"),
		preload("res://assets/audio/effects/KeepitsafeTROLL8.wav")
	],
	TrollMood.Hmm: [
		preload("res://assets/audio/effects/KeepitsafeTROLL2.wav"),
		preload("res://assets/audio/effects/KeepitsafeTROLL1.wav"),
		preload("res://assets/audio/effects/KeepitsafeTROLL3.wav")
	],
	TrollMood.Take: [
		preload("res://assets/audio/effects/KeepitsafeTROLL4.wav"),
		preload("res://assets/audio/effects/KeepitsafeTROLL5.wav"),
		preload("res://assets/audio/effects/KeepitsafeTROLL6.wav")
	]
}

var is_revealed: bool

func _ready() -> void:
	Events.trollResponse.connect(_on_troll_response)

func _on_troll_response(mood: TrollMood):
	if mouth.playing:
		return
	mouth.stream = sounds[mood].pick_random()
	mouth.play()

func _on_area_entered(area: Area2D) -> void:
	if is_revealed:
		return
	if area.owner is Player:
		is_revealed = true
		area.owner.stopped = true
		var tween = create_tween().set_ease(Tween.EASE_IN)
		sprite.modulate.a = 0.0
		sprite.show()
		tween.tween_property(sprite, "modulate:a", 1.0, 2.0)
