class_name FallingItem extends Node2D

@export var speed = 80
@export var rotation_speed = 40
@export var acc = 200

var item_data: FallableItem
var destroying = false
var rotate_scale = 1

func refresh_item_data():
	$Sprite2D.texture = item_data.sprite
	$AudioStreamPlayer2D.stream = item_data.collect_sound

func _ready():
	if randi() % 2:
		rotate_scale = -1
	
	refresh_item_data()
	
func _physics_process(delta):
	position.y += delta * speed
	speed += acc * delta
	
	rotation += delta * rotation_speed * rotate_scale

func on_pickup(_area):
	$AudioStreamPlayer2D.play()
	match item_data.score_effect:
		FallableItem.ItemType.PositiveScore:
			ScoreManager.score += 50
		FallableItem.ItemType.NegativeScore:
			ScoreManager.score -= 50
	call_deferred("destroy_deferred")

func destroy_deferred():
	destroying = true
	$Sprite2D.visible = false
	$Area2D/CollisionShape2D.disabled = true
	await $AudioStreamPlayer2D.finished
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if not destroying:
		queue_free()
