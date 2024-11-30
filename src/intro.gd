extends Node2D
@onready var cam: Camera2D = %Cam

var bottom_y := 1260.0
const intro_track = preload("res://assets/audio/KeepITsafe - intro meny.wav")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	_start_sequence.call_deferred()


func _start_sequence():
	await Audio.transition_to(intro_track)
	var cam_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	await cam_tween.tween_property(cam, "position:y", bottom_y, 12.0).finished
	
	await Utility.fade_to_black(self, 1.69).finished
	get_tree().change_scene_to_file("res://main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
