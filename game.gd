extends Control


const InputResponse = preload("res://input_response.tscn")

@onready var history = $background/margins/rows/info_panel/history

 
func _on_input_line_text_submitted(new_text: String) -> void:
	var input_response = InputResponse.instantiate()
	history.add_child(input_response)
