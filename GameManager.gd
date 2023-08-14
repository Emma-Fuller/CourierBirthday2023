extends Node2D

@export var item = preload("res://Prefabs/FallingItem/FallingItem.tscn")
@export var items: Array[FallableItem]

func spawn_item():
	var new_item = item.instantiate() as FallingItem

	new_item.position.x = get_random_window_x()
	new_item.item_data = get_random_item_data()

	add_child(new_item)
	
func get_random_item_data() -> FallableItem:
	return items[randi() % items.size()]
	
func get_random_window_x() -> int:
	var window_size = get_viewport_rect().size
	return randi_range(0, window_size.x)
	
