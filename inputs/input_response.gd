extends MarginContainer

@onready var zebra = $zebra
@onready var input_label = $rows/input_history
@onready var response_label = $rows/response


func set_text(response: String, input: String = ""):
	if input == "":
		input_label.queue_free()
	else:
		input_label.text = " > " + input
	
	response_label.text = response
