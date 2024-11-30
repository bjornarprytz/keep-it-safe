extends Area2D


@onready var sprite: Sprite2D = %Sprite


func _on_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		var tween = create_tween().set_ease(Tween.EASE_IN)
		sprite.modulate.a = 0.0
		sprite.show()
		tween.tween_property(sprite, "modulate:a", 1.0, 2.0)
