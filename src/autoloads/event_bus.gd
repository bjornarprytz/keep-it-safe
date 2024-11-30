class_name EventBus
extends Node2D

var result: bool

func _ready() -> void:
	gameOver.connect(_on_game_over)

func _on_game_over(success: bool):
	result = success

signal gameOver(success:bool)
