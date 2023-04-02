extends VBoxContainer


func set_text(input: String, response: String):
	$input_history.text = " > " + input
	$response.text = response
