extends HBoxContainer

@export_enum("first", "second") var input_type = "first"

const inputs: Array[String] = [
	"left",
	"up",
	"down",
	"right",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	create_input_labels()
	pass # Replace with function body.


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
		new_button.set_button_label(key)
		add_child(new_button)
		add_child(divider_scene.instantiate())

func set_button_state(button_input: String, state: bool) -> void:
	var button: LaneStaticButton = get_node_or_null(button_input)
	if button != null:
		button.set_button_state(state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
