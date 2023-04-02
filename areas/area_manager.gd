extends Node


func _ready() -> void:
	$inside.connect_exits("east", $outside)
