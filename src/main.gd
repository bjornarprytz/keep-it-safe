extends Node2D

@onready var camera: Camera2D = %Camera
@onready var player: CharacterBody2D = %Player
@onready var dialogue: Dialogue = %Dialogue
@onready var foreground_parallax: Parallax2D = %ForegroundParallax
const scary_track = preload("res://assets/audio/KeepitsafeSCARYAMBIENT.wav")

@onready var text:DialogueResource  = preload("res://dialogue/test.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.gameOver.connect(on_game_over)
	Utility.fade_from_black(self, 1.69)
	Utility.fade_from_black(foreground_parallax, 1.69)
	Audio.transition_to(scary_track)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	camera.position.x = player.position.x

func _on_exit_body_entered(body: Node2D) -> void:
	if body.owner is Player:
		get_tree().call_deferred("reload_current_scene")


func _on_troll_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		$UI.show()
		dialogue.start(text, "start")

func on_game_over(success: bool):
	get_tree().change_scene_to_file("res://outro.tscn")
