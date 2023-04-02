extends LineEdit


func _ready() -> void:
	grab_focus()


func _on_text_submitted(new_text: String) -> void:
	clear()
