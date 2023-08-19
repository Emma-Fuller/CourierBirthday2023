class_name FallingItem extends Node2D

@export var speed = 80
@export var rotation_speed = 40
@export var acc = 200

var item_data: FallableItem
var destroying = false
var rotate_scale = 1

var drop_controller

func refresh_item_data():
	$Sprite2D.texture = item_data.sprite
	$AudioStreamPlayer2D.stream = item_data.collect_sound

func _ready():
	drop_controller = get_parent()
	rotation = randf_range(0, 2 * PI)
	if randi() % 2:
		rotate_scale = -1

	refresh_item_data()
	
func _physics_process(delta):
	position.y += delta * speed
	speed += acc * delta
	
	rotation += delta * rotation_speed * rotate_scale
	
	if drop_controller.magnet_active:
		var player = get_tree().get_first_node_in_group("player")
		var distance = player.position.x - position.x
		
		var dir = -1 if player.position.x - position.x < 0 else 1
		
		if item_data.score_value < 0:
			dir *= -1
	
		if abs(distance) > 10:
			position += Vector2(dir, 0) * 100 * delta
		

func on_pickup(_area):
	$AudioStreamPlayer2D.play()
	ScoreManager.score += item_data.score_value
	destroy_deferred.call_deferred()
	
	drop_controller.item_got(item_data.name)

func destroy_deferred():
	destroying = true
	$Sprite2D.visible = false
	$Area2D/CollisionShape2D.disabled = true
	await $AudioStreamPlayer2D.finished
	
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if not destroying:
		queue_free()
