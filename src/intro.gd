extends Node2D
@onready var cam: Camera2D = %Cam

var has_started: bool
var bottom_y := 1260.0
const intro_track = preload("res://assets/audio/KeepITsafe - intro meny.wav")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventKey:
		_start_sequence()

func _start_sequence():
	if has_started:
		return
	has_started = true
	await Audio.transition_to(intro_track)
	var cam_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	await cam_tween.tween_property(cam, "position:y", bottom_y, 8.0).finished
	
	await Utility.fade_to_black(self, 1.69).finished
	get_tree().change_scene_to_file("res://main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
