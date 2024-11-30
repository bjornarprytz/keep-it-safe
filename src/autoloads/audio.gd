extends AudioStreamPlayer

func _ready() -> void:
	finished.connect(play)

func transition_to(audio: AudioStream):
	var fade_out = create_tween()
	fade_out.tween_property(self, "volume_db", -80, .69)
	await fade_out.finished
	stop()
	stream = audio
	play()
	var fade_in = create_tween()
	fade_in.tween_property(self, "volume_db", -10, .69)
	
	
	
	
