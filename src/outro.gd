extends Node2D

const failure_track = preload("res://assets/audio/KeepitsafeFailure.wav")

func _ready() -> void:
	if !Events.result:
		Audio.transition_to(failure_track)
