class_name ItemPool extends Resource

@export var items: Array[FallableItem]

func pick_random() -> FallableItem:
	return items.pick_random()
