extends CharacterBody2D

class_name FallingButton

@export var initial_velocity := Vector2.DOWN
var label := "w"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label
	self.velocity = initial_velocity


# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
