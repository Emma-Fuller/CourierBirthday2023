extends Node2D

@export var drop_margin = 200
var item = preload("res://Prefabs/FallingItem/FallingItem.tscn")
var pool: ItemPool

var defaultPool := preload("res://Resources/Pools/DefaultItemPool.tres")
var pewPewPowerPool := preload("res://Resources/Pools/PewPewPowerPool.tres")

var magnet_active := false

func _ready():
	pool = defaultPool

func spawn_item():
	var new_item = item.instantiate() as FallingItem

	new_item.position.x = get_random_window_x()
	new_item.item_data = pool.pick_random()

	new_item.add_to_group("items")
	add_child(new_item)
	
func get_random_window_x() -> int:
	var window_size = get_viewport_rect().size
	return randi_range(0 + drop_margin, window_size.x - drop_margin)

func on_game_ended():
	$"Spawn Timer".stop()
	await get_tree().create_timer(2).timeout	
	get_window().add_child.call_deferred(
		load("res://Prefabs/EndCard/EndCard.tscn").instantiate()
	)

	queue_free()
	
func item_got(item_name: String):
	match item_name:
		"PewPew":
			pool = pewPewPowerPool
			
			var air: Array = get_tree().get_nodes_in_group("items")
			for old_item in air:
				if old_item.item_data.name != "PewPew":
					old_item.item_data = pool.pick_random()
					old_item.refresh_item_data()
			
			await get_tree().create_timer(5).timeout
			pool = defaultPool
		"Tealberry":
			magnet_active = true
			await get_tree().create_timer(5).timeout
			magnet_active = false
	
	
