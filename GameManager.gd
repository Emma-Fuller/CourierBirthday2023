extends Node2D

@export var item = preload("res://Prefabs/FallingItem/FallingItem.tscn")
@export var items: Array[FallableItem]

func spawn_item():
	var new_item = item.instantiate() as FallingItem

	new_item.position.x = get_random_window_x()
	new_item.item_data = get_random_item_data()

	add_child(new_item)
	
@export var do_filter = false
func get_random_item_data() -> FallableItem:
	var list = items.filter(is_positive) if do_filter else items
	return list[randi() % list.size()]
	
func get_random_window_x() -> int:
	var window_size = get_viewport_rect().size
	return randi_range(0, window_size.x)
	
func is_positive(i: FallableItem) -> bool:
	return i.score_effect == FallableItem.ItemType.PositiveScore
