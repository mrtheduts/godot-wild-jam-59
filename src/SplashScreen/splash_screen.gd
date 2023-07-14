extends Control

signal ended

# Variables visible within the editor:
export(AudioStream) var initial_sound_effect;
export(float, 1.0, 5.0, 0.5) var duration := 3.5
export(float, 1.0, 5.0, 0.5) var fade_in_duration := 1.5
export(float, 1.0, 5.0, 0.5) var fade_out_duration := 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	start_fade_tween()
	play_growl_effect()
	listen_to_timeout_and_free_itself()

# Creates tween to change transparency of logo over time
func start_fade_tween() -> void:
	var tween: SceneTreeTween = get_tree().create_tween()
	tween.tween_property($MarginContainer/TextureRect, "modulate", Color.white, fade_in_duration)
	tween.tween_interval(duration - fade_in_duration - fade_out_duration)
	tween.tween_property(self, "modulate", Color.black, fade_out_duration)

# Instantiates an AudioStreamPlayer and plays growl effect after added to tree
func play_growl_effect() -> void:
	var player := AudioStreamPlayer.new()
	player.autoplay = true
	player.volume_db = -10
	player.stream = initial_sound_effect
	add_child(player)

# Creates timer to emit signal after time has elapsed
func listen_to_timeout_and_free_itself() -> void:
	var timer: SceneTreeTimer = get_tree().create_timer(duration)
	timer.connect("timeout", self, "emit_ended")

# Emits ended signal
func emit_ended() -> void:
	emit_signal("ended")
