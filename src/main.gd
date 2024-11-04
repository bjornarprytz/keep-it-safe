extends Node2D

@onready var camera: Camera2D = %Camera
@onready var player: CharacterBody2D = %Player
@onready var dialogue: Dialogue = %Dialogue
@onready var nøkken: Sprite2D = %"Nøkken"


@onready var text:DialogueResource  = preload("res://dialogue/test.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	camera.position.x = player.position.x

func _on_exit_body_entered(body: Node2D) -> void:
	
	$UI.show()
	dialogue.start(text, "test_dialogue")
	
	#print("%s exited" % [body.name])
	#get_tree().call_deferred("reload_current_scene") # TODO: Load next scene, not the same
