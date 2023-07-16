extends Control

const input_events: Array[String] = [
	"first_left",
	"first_up",
	"first_down",
	"first_right",
	"second_left",
	"second_up",
	"second_down",
	"second_right",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	if event is InputEventKey:
		for input in input_events:
			if event.is_action_pressed(input):
				if input.begins_with("first"):
					%FirstFallingLanes.set_button_state(input.get_slice("_", 1), true)
				else:
					%SecondFallingLanes.set_button_state(input.get_slice("_", 1), true)
			elif event.is_action_released(input):
				if input.begins_with("first"):
					%FirstFallingLanes.set_button_state(input.get_slice("_", 1), false)
				else:
					%SecondFallingLanes.set_button_state(input.get_slice("_", 1), false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
