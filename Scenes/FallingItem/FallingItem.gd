class_name FallingItem extends Node2D

@export var speed = 80
@export var rotation_speed = 40
@export var acc = 200

var item_data: FallableItem
var destroying = false
var rotate_scale = 1

var drop_controller

func refresh_item_data():
	$"Item Sprite".texture = item_data.sprite
	$"Collect Sound".stream = item_data.collect_sound

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
	
	if PowerupManager.tealberryactive and item_data.score_value > 0:
		var basket: Node2D = get_tree().get_first_node_in_group("basket")
		if basket and global_position.distance_to(basket.global_position) < 200:
			global_position = global_position.move_toward(
				basket.global_position,
				clamp(global_position.distance_to(basket.global_position), 0, 10)
			)
		

func on_pickup(_area):
	$"Collect Sound".play()
	ScoreManager.score += item_data.score_value
	destroy_deferred.call_deferred()
	
	if item_data.score_value < 0:
		var player = get_tree().get_first_node_in_group("player")
		player.stun_for(1)
	
	drop_controller.item_got(item_data.name)

func destroy_deferred():
	destroying = true
	$"Item Sprite".visible = false
	$"Collider/Collision Area".disabled = true
	await $"Collect Sound".finished
	
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if not destroying:
		queue_free()
