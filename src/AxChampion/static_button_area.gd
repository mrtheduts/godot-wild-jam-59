extends Area2D

class_name StaticButtonArea

var button_on_touch: FallingButton = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is FallingButton:
		button_on_touch = body


func _on_body_exited(body):
	if body is FallingButton:
		button_on_touch = null


func get_distance_to_button() -> float:
	if button_on_touch == null:
		return INF
	return (button_on_touch.position - self.position).length()
