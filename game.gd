extends Control

@onready var info_panel = $interface/margins/columns/rows/info_panel
@onready var parser = $parser
@onready var area_manager = $area_manager
@onready var player = $player
@onready var side_panel = $interface/margins/columns/side_panel


func _ready() -> void:	
	parser.area_changed.connect(side_panel.handle_area_changed)
	parser.area_updated.connect(side_panel.handle_area_updated)
	
	info_panel.create_response("Welcome to [color=orange]Deep Dark Dungeons of Doom[/color] (v0.0.1-alpha)!\n(Important disclaimer: There are currently no deep dark dungeons in the game.)\n\nYou wake up in a stinking dung heap. Also, you feel like a stinking dung heap. Your head is pounding. Your limbs ache. There's this unquenchable thirst. And although the sky is cloudy, the sun shines far too brightly. A rooster crows in the distance. It's really time to go to bed.")
	
	var starting_area_response = parser.initialize(area_manager.get_child(0), player)
	info_panel.create_response(starting_area_response)


func _on_input_line_text_submitted(new_text: String) -> void:
	var response = parser.process_command(new_text)
	info_panel.create_response_with_input(response, new_text)
