class_name Player
extends CharacterBody2D

enum PlayerMood {
	Surprise,
	Intrigued,
	Greedy,
	Shoo,
	OhNo,
	Hey
}

const back_sprite = preload("res://assets/character-back.png")
const normal = preload("res://assets/character-normal.png")


const surprise1 = preload("res://assets/audio/effects/KeepitsafeBABY1.wav")
const surprise2 = preload("res://assets/audio/effects/KeepitsafeBABY2.wav")

const intrigued1 = preload("res://assets/audio/effects/KeepitsafeBABY3.wav")
const intrigued2 = preload("res://assets/audio/effects/KeepitsafeBABY10.wav")
const intrigued3 = preload("res://assets/audio/effects/KeepitsafeBABY14.wav")

const greedy1 = preload("res://assets/audio/effects/KeepitsafeBABY4.wav")
const greedy2 = preload("res://assets/audio/effects/KeepitsafeBABY12.wav")

const shoo1 = preload("res://assets/audio/effects/KeepitsafeBABY5.wav")
const shoo2 = preload("res://assets/audio/effects/KeepitsafeBABY6.wav")

const ohno1 = preload("res://assets/audio/effects/KeepitsafeBABY7.wav")
const ohno2 = preload("res://assets/audio/effects/KeepitsafeBABY8.wav")

const hey1 = preload("res://assets/audio/effects/KeepitsafeBABY9.wav")
const hey2 = preload("res://assets/audio/effects/KeepitsafeBABY11.wav")
const hey3 = preload("res://assets/audio/effects/KeepitsafeBABY13.wav")

var sounds: Dictionary = {
	PlayerMood.Surprise: [
		surprise1,
		surprise2
	],
	PlayerMood.Intrigued : [
		intrigued1,
		intrigued2,
		intrigued3
	],
	PlayerMood.Greedy: [
		greedy1,
		greedy2
	],
	PlayerMood.Shoo: [
		shoo1,
		shoo2
	],
	PlayerMood.OhNo: [
		ohno1,
		ohno2
	],
	PlayerMood.Hey: [
		hey1,
		hey2,
		hey3
	]
}
@onready var pixel: Pixel = %Pixel
@onready var sprite: Sprite2D = %Sprite
@onready var mouth: AudioStreamPlayer2D = %Mouth

const SPEED = 200.0

const utterance_cooldown: float = 4.69
var is_utter_cooldown: bool

var stopped: bool:
	set(value):
		stopped = value
		if stopped:
			sprite.texture = back_sprite
			move_child(pixel, 0)
		else:
			sprite.texture = normal
			move_child(pixel, 2)

func _ready() -> void:
	Events.playerMood.connect(_on_player_mood)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (stopped):
		return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_pixel_area_entered(area: Area2D) -> void:
	if (area.owner is Moth):
		utter

func _on_player_mood(mood: PlayerMood):
	var stream = sounds[mood].pick_random()
	
	utter(stream)

func utter(audio: AudioStream):
	if is_utter_cooldown or mouth.playing:
		return
	is_utter_cooldown = true
	
	mouth.stream = audio
	mouth.play()
	
	await get_tree().create_timer(utterance_cooldown).timeout
	is_utter_cooldown = false
