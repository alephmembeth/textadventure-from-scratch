extends Node


func _ready() -> void:
	$behind_inn.connect_exits_unlocked("alley", $street_3, "alley")
	var exit = $behind_inn.connect_exits_locked("shed", $shed, "outside")
	var key = load_item("key")
	key.use_value = exit
	$behind_inn.add_item(key)
	
	var guard = load_character("guard")
	$city_gate.add_character(guard)
	$city_gate.connect_exits_unlocked("east", $street_1)
	
	$street_1.connect_exits_unlocked("east", $street_2)
	
	$street_2.connect_exits_unlocked("east", $street_3)
	
	$street_3.connect_exits_unlocked("east", $street_4)
	
	$street_4.connect_exits_unlocked("east", $street_5)
	$street_4.connect_exits_unlocked("door", $inn_door, "street")
	
	$street_5.connect_exits_unlocked("east", $street_6)
	
	$street_6.connect_exits_unlocked("east", $street_7)
	
	$street_7.connect_exits_unlocked("east", $street_8)
	
	$inn_door.connect_exits_unlocked("inside", $taproom, "outside")
	
	var innkeeper = load_character("innkeeper")
	$taproom.add_character(innkeeper)
	$taproom.connect_exits_unlocked("stairs", $stairs, "taproom")
	$taproom.connect_exits_unlocked("kitchen", $kitchen, "taproom")
	
	$stairs.connect_exits_unlocked("downstairs", $cellar_door, "upstairs")
	$stairs.connect_exits_unlocked("upstairs", $upstairs_hallway, "downstairs")
	
	$cellar_door.connect_exits_unlocked("cellar", $cellar, "stairs")
	
	$upstairs_hallway.connect_exits_unlocked("left", $room_1, "hallway")
	$upstairs_hallway.connect_exits_unlocked("center", $room_2, "hallway")
	$upstairs_hallway.connect_exits_unlocked("right", $room_2, "hallway")
	
	var cook = load_character("cook")
	$kitchen.add_character(cook)
	$kitchen.connect_exits_unlocked("pantry", $pantry, "kitchen")
	$kitchen.connect_exits_unlocked("backdoor", $backdoor, "kitchen")
	
	$backdoor.connect_exits_unlocked("outside", $behind_inn, "inside")


func load_item(item_name: String):
	return load("res://items/" + item_name + ".tres")


func load_character(character_name: String):
	return load("res://characters/" + character_name + ".tres")
