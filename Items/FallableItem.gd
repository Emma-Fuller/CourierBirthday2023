class_name FallableItem extends Resource

enum ItemType {
	PositiveScore,
	NegativeScore,
	NeutralScore
}

@export var name: String
@export var sprite: Texture2D
@export var collect_sound: AudioStream
@export var score_effect: ItemType
