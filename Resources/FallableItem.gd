class_name FallableItem extends Resource

@export var name: String
@export_enum(
	"Bad:-100",
	"Neutral:0",
	"Mildly Good:10",
	"Good:50"
) var score_value: int

@export var sprite: Texture2D
@export var collect_sound: AudioStream

func eq(other: FallableItem):
	return name == other.name
