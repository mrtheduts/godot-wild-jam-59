extends CharacterBody2D

@export var character_spritesheet: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = character_spritesheet


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
