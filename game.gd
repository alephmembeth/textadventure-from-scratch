extends Control

const InputResponse = preload("res://input_response.tscn")

@export var max_lines_remembered := 42

var max_scroll_length := 0

@onready var history = $background/margins/rows/info_panel/scroll/history
@onready var scroll = $background/margins/rows/info_panel/scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value


func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length

 
func _on_input_line_text_submitted(new_text: String) -> void:
	if new_text.is_empty() or new_text.begins_with(" "): 
		return

	var input_response = InputResponse.instantiate()
	input_response.set_text(new_text, "Okay, cool.")
	history.add_child(input_response)

	if history.get_child_count() > max_lines_remembered:
		var rows_to_forget = history.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history.get_child(i).queue_free()
