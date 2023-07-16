extends MarginContainer

class_name LaneStaticButton

## Sets button text
func set_button_label(label: String) -> void:
	$Button.text = label


## Sets button pressed state without triggering its signal
func set_button_state(state: bool) -> void:
	$Button.set_pressed_no_signal(state)
