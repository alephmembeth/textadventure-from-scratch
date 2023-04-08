extends Control

@onready var info_panel = $interface/margins/rows/info_panel
@onready var parser = $parser
@onready var area_manager = $area_manager
@onready var player = $player


func _ready() -> void:
	info_panel.create_response("Welcome to the text adventure!")
	
	var starting_area_response = parser.initialize(area_manager.get_child(0), player)
	info_panel.create_response(starting_area_response)


func _on_input_line_text_submitted(new_text: String) -> void:
	if new_text.is_empty() or new_text.begins_with(" "):
		return
	
	var response = parser.process_command(new_text)
	info_panel.create_response_with_input(response, new_text)
