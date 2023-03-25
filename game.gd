extends Control

const Response = preload("res://response.tscn")
const InputResponse = preload("res://input_response.tscn")

var max_scroll_length := 0

@export var max_lines_remembered := 42

@onready var parser = $parser
@onready var history = $background/margins/rows/info_panel/scroll/history
@onready var scroll = $background/margins/rows/info_panel/scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value
	var starting_message = Response.instantiate()
	starting_message.text = "You find yourself in a house, with no memory how you got there. You need to find your way out."
	add_response(starting_message)


func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length

 
func _on_input_line_text_submitted(new_text: String) -> void:
	if new_text.is_empty() or new_text.begins_with(" "): 
		return
	
	var input_response = InputResponse.instantiate()
	var response = parser.process_command(new_text)
	input_response.set_text(new_text, response)
	add_response(input_response)


func add_response(response: Control):
	history.add_child(response)
	delete_history()


func delete_history():
	if history.get_child_count() > max_lines_remembered:
		var rows_to_forget = history.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history.get_child(i).queue_free()	
