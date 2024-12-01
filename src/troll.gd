extends Area2D


@onready var sprite: Sprite2D = %Sprite

var is_revealed: bool


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
