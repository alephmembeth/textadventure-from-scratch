extends MarginContainer


func set_text(input: String, response: String):
	$rows/input_history.text = " > " + input
	$rows/response.text = response
