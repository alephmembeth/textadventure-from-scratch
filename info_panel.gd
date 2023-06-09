extends PanelContainer

const InputResponse = preload("res://inputs/input_response.tscn")

var max_scroll_length := 0
@export var max_lines_remembered := 42

var show_zebra := false

@onready var scroll = $scroll
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var history = $scroll/history


func _ready() -> void:
	scrollbar.changed.connect(_handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value


func create_response(response_text: String):
	var response = InputResponse.instantiate()
	_add_response(response)
	response.set_text(response_text)


func create_response_with_input(response_text: String, input_text: String):
	var input_response = InputResponse.instantiate()
	_add_response(input_response)
	input_response.set_text(response_text, input_text)


func _handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _delete_history():
	if history.get_child_count() > max_lines_remembered:
		var rows_to_forget = history.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history.get_child(i).queue_free()


func _add_response(response: Control):
	history.add_child(response)
	if not show_zebra:
		response.zebra.hide()
	show_zebra = !show_zebra
	_delete_history()
