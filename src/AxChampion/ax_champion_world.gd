extends Node2D

var vertical_pos: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_falling_button(button: Node) -> void:
	add_child(button)

func create_collision_shapes(button_positions: Dictionary) -> void:
	vertical_pos = (get_parent().canvas_transform.affine_inverse() * button_positions[button_positions.keys()[0]]).y
	var static_button_area_scene: PackedScene = load("res://src/AxChampion/static_button_area.tscn")
	for key in button_positions:
		var horizontal_pos: float = (get_parent().canvas_transform.affine_inverse() * button_positions[key]).x
		var new_area: Area2D = static_button_area_scene.instantiate()
		new_area.name = key
		new_area.position.x = horizontal_pos
		new_area.position.y = vertical_pos
		add_child(new_area)

func get_distance_to_button(button_name: String) -> float:
	var button_area: StaticButtonArea = get_node_or_null(button_name)
	return button_area.get_distance_to_button()
