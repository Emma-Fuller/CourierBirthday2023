class_name ItemPool extends Resource

@export var items: Array[FallableItem]

func pick_random() -> FallableItem:
	return items.pick_random()
	
func contains(item: FallableItem):
	return items.any(
		func(i: FallableItem): return item.eq(i)
	)
