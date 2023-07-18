extends MarginContainer

class_name LaneStaticButton

## Sets button text
func set_button_label(label: String) -> void:
	$Button.text = label

## Gets button text
func get_button_label() -> String:
	return $Button.text


## Sets button pressed state without triggering its signal
func set_button_state(state: bool) -> void:
	$Button.set_pressed_no_signal(state)


## Returns the center position of the button on the screen
func get_button_center_pos_on_screen() -> Vector2:
	var button_rect: Rect2 = $Button.get_rect()
	var button_pos: Vector2 = $Button.get_screen_position()
	return button_pos + button_rect.size/2
