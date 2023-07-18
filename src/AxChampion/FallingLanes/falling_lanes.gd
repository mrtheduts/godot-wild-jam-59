extends HBoxContainer

signal positions_updated
signal falling_button_created

const inputs: Array[String] = [
	"left",
	"up",
	"down",
	"right",
]

## Enum to identify which set of inputs it will be.
@export_enum("first", "second") var input_type = "first"

var button_positions: Dictionary
var buttons: Array[LaneStaticButton] = []

@onready var falling_button_scene: PackedScene = load("res://src/AxChampion/FallingButton/falling_button.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	create_input_labels()
	await get_tree().process_frame # Wait for a frame to be drawn
	button_positions = get_buttons_center_pos_on_screen()


func create_input_labels() -> void:
	var divider_scene: PackedScene = load("res://src/AxChampion/FallingLanes/divider.tscn")
	var static_button_scene: PackedScene = load("res://src/AxChampion/FallingLanes/LaneStaticButton/lane_static_button.tscn")
	add_child(divider_scene.instantiate())
	
	for input in inputs:
		var input_events := InputMap.action_get_events(input_type + "_" + input)
		var input_event_keys = input_events.filter(func(e): return e is InputEventKey)
		
		assert(input_event_keys.size() > 0)
		
		var key = (input_event_keys[0] as InputEventKey).as_text_physical_keycode().to_lower()
		var new_button: LaneStaticButton = static_button_scene.instantiate()
		new_button.name = input
		new_button.set_button_label(key if key.length() == 1 else get_simple_char_for_complex_input_text(key))
		
		buttons.append(new_button)
		add_child(new_button)
		add_child(divider_scene.instantiate())


func get_simple_char_for_complex_input_text(input_text: String) -> String:
	var res: String
	if input_text == "left":
		res = "←"
	elif input_text == "right":
		res = "→"
	elif input_text == "up":
		res = "↑"
	elif input_text == "down":
		res = "↓"
	return res


func get_buttons_center_pos_on_screen() -> Dictionary:
	var positions: Dictionary = {}
	for child in get_children():
		if child is LaneStaticButton:
			positions[child.name] = (child as LaneStaticButton).get_button_center_pos_on_screen()
	return positions


func set_button_state(button_input: String, state: bool) -> void:
	var button: LaneStaticButton = get_node_or_null(button_input)
	if button != null:
		button.set_button_state(state)
		if state:
			create_falling_button_on(button_input)


func create_falling_button_on(lane: String) -> void:
	var new_falling_button: CharacterBody2D = falling_button_scene.instantiate()
	new_falling_button.label = buttons.filter(func(btn): return btn.name == lane)[0].get_button_label()
	var button_position: Vector2 = button_positions[lane]
	falling_button_created.emit(new_falling_button, button_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resized():
	await get_tree().process_frame # Wait for a frame to be drawn
	button_positions = get_buttons_center_pos_on_screen()
	positions_updated.emit()
