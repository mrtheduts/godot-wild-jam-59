extends Control

@export var base_button_duration: float = 5.0
@export_range(1.0, 10.0, 0.5) var fall_multiplier := 1.0

@export var base_button_score: float = 20
@export_range(1.0, 10.0, 1.0) var score_multiplier := 1

@export var step_to_increase_multiplier: int = 10

var has_created_areas := false

var curr_combo := 0
var curr_score := 0.0

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
	pass
	


func _unhandled_input(event):
	if not has_created_areas:
		await get_tree().process_frame # Wait for a frame to be drawn
		var final_dict: Dictionary = {}
		var first_dict: Dictionary = %FirstFallingLanes.button_positions
		for key in first_dict:
			final_dict["first_" + key] = first_dict[key]
		var second_dict: Dictionary = %SecondFallingLanes.button_positions
		for key in first_dict:
			final_dict["second_" + key] = second_dict[key]
		%AxChampionWorld.create_collision_shapes(final_dict)
		has_created_areas = true
	
	if event is InputEventKey:
		for input in input_events:
			if event.is_action_pressed(input):
				var distance: float = %AxChampionWorld.get_distance_to_button(input)
				if input.begins_with("first"):
					%FirstFallingLanes.set_button_state(input.get_slice("_", 1), true)
				else:
					%SecondFallingLanes.set_button_state(input.get_slice("_", 1), true)
					
				if distance == INF:
					curr_combo = 0
					score_multiplier = 0
				else:
					curr_combo += 1
					if curr_combo % step_to_increase_multiplier == 0:
						score_multiplier += 1
					curr_score += base_button_score * score_multiplier / distance
				$HBoxContainer/RightHalf/VBoxContainer/HBoxContainer/ComboBox/Value.text = String.num_uint64(curr_combo)
				$HBoxContainer/RightHalf/VBoxContainer/HBoxContainer/MultiplierBox/Value.text = String.num(score_multiplier, 0)
				$HBoxContainer/RightHalf/VBoxContainer/HBoxContainer/ScoreBox/Value.text = String.num(curr_score, 0)
				
			elif event.is_action_released(input):
				if input.begins_with("first"):
					%FirstFallingLanes.set_button_state(input.get_slice("_", 1), false)
				else:
					%SecondFallingLanes.set_button_state(input.get_slice("_", 1), false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_falling_lanes_falling_button_created(falling_button: CharacterBody2D, final_button_pos: Vector2):
	var lenght := final_button_pos.y + 25
	var speed := (lenght/base_button_duration) * fall_multiplier
	final_button_pos.y = -25
	# Transforms screen position to World 2D position to align falling button into correct lane
	var pos: Vector2 = $SubViewportContainer/SubViewport.canvas_transform.affine_inverse() * final_button_pos
	falling_button.position = pos
	falling_button.initial_velocity.y *= speed
	%AxChampionWorld.add_child(falling_button)
