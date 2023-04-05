extends Node


func _ready() -> void:
	var key = Item.new()
	key.initialize("key", Types.item_types.KEY)
	
	$inside.connect_exits_unlocked("east", $outside)
	
	$outside.add_item(key)
	var exit = $outside.connect_exits_locked("east", $shed)
	key.use_value = exit
	$outside.connect_exits_unlocked("north", $street)
