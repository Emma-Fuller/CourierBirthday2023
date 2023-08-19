class_name FallableItem extends Resource

@export var name: String
@export var sprite: Texture2D
@export var collect_sound: AudioStream
@export var score_value: int

func eq(other: FallableItem):
	return name == other.name
