extends Node


func _ready() -> void:
	var key = Item.new()
	key.initialize("key", Types.item_types.KEY)
	
	$inside.connect_exits("east", $outside)
	$inside.add_item(key)
