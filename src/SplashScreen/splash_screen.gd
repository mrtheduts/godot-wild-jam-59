extends Control

## Shows the Godot Wild Jam logo with a sound effect and fade-in and fade-out effects.
class_name SplashScreen

## Emitted when fade-out has ended
signal animation_ended

## Duration which Splash Screen will be shown for (seconds).
@export_range(0.0, 10.0, 0.5) var duration := 6.0

@export_group("Sound Effect")
@export var sound_effect: AudioStream ## Sound effect to be played on scene start.
@export_range(-80.0, 24.0, 0.5) var sound_effect_volume := -10 ## Initial volume for sound effect.

@export_group("Fade Durations")
@export_range(0.0, 5.0, 0.5) var fade_in_duration := 1.5 ## Fade-in duration (seconds).
@export_range(0.0, 5.0, 0.5) var fade_out_duration := 1.5 ## Fade-out duration (seconds).


# Called when the node enters the scene tree for the first time.
func _ready():
	start_fade_tween()
	play_sound()


## Creates tween for fade-in and fade-out animations.
## Also emits 'animation_ended' signal on tween end.
func start_fade_tween() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property($TextureRect, "modulate", Color.WHITE, fade_in_duration)
	tween.tween_interval(duration - fade_in_duration - fade_out_duration)
	tween.tween_property(self, "modulate", Color.BLACK, fade_out_duration)
	tween.tween_callback(func(): animation_ended.emit())


## Plays animation sound on ready.
func play_sound() -> void:
	if sound_effect != null:
		var player := AudioStreamPlayer.new()
		player.stream = sound_effect
		player.volume_db = sound_effect_volume
		player.autoplay = true
		add_child(player)
