extends Node2D

const failure_track = preload("res://assets/audio/KeepitsafeFailure.wav")
const success_track = preload("res://assets/audio/KeepitsafeSCARYAMBIENT.wav")

func _ready() -> void:
	if Events.result:
		Audio.transition_to(success_track)
	else:
		Audio.transition_to(failure_track)
