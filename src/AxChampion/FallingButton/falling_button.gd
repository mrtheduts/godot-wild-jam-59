extends Node2D

@export_enum(
	"first_left", \
	"first_up", \
	"first_down", \
	"first_right", \
	"second_left", \
	"second_up", \
	"second_down", \
	"second_right", \
) var input_type := "first_left"

@export var label := "w"

func _init(label: String):
	self.label = label

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label


func set_label_from_input_type() -> void:
	var input_actions := InputMap.action_get_events(input_type)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
