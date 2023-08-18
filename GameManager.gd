extends Node2D

@export var drop_margin = 200
var item = preload("res://Prefabs/FallingItem/FallingItem.tscn")
@export var items: Array[FallableItem]

func spawn_item():
	print("BLEHHHHH")
	var new_item = item.instantiate() as FallingItem

	new_item.position.x = get_random_window_x()
	new_item.item_data = get_random_item_data()

	new_item.add_to_group("items")
	add_child(new_item)
	
@export var do_filter = false
func get_random_item_data() -> FallableItem:
	var list = items.filter(is_positive) if do_filter else items
	return list[randi() % list.size()]
	
func get_random_window_x() -> int:
	var window_size = get_viewport_rect().size
	return randi_range(0 + drop_margin, window_size.x - drop_margin)
	
func is_positive(i: FallableItem) -> bool:
	return i.score_effect == FallableItem.ItemType.PositiveScore

func on_game_ended():
	$Timer.stop()
	
	while get_tree().get_nodes_in_group("items").size():
		await get_tree().create_timer(0.1).timeout
		
	get_window().add_child.call_deferred(
		load("res://Prefabs/EndCard/EndCard.tscn").instantiate()
	)

	queue_free()
	
