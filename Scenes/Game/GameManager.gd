extends Node2D

var drop_margin = 100
var item = preload("res://Scenes/FallingItem/FallingItem.tscn")
var pool: ItemPool

var defaultPool := preload("res://Resources/Pools/DefaultItemPool.tres")
var pewPewPowerPool := preload("res://Resources/Pools/PewPewPowerPool.tres")

var magnet_active := false

var pewpewtimer = Timer.new()
var tealberrytimer = Timer.new()

@onready var PewPewArea := $PowerBars/PewPew
@onready var PewPewBar := $PowerBars/PewPew/PewPewBar

@onready var TealberryArea := $PowerBars/Tealberry
@onready var TealberryBar := $PowerBars/Tealberry/BerryBar

func _ready():
	pool = defaultPool

	add_child(pewpewtimer)
	pewpewtimer.timeout.connect(end_pewpew_time)
	add_child(tealberrytimer)
	tealberrytimer.timeout.connect(end_tealberry_time)

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
	await get_tree().create_timer(3).timeout
	get_window().add_child.call_deferred(
		load("res://Scenes/EndCard/EndCard.tscn").instantiate()
	)

	queue_free()
	
func item_got(item_name: String):
	match item_name:
		"PewPew":
			PewPewArea.visible = true
			$"Spawn Timer".wait_time = 0.50
			pool = pewPewPowerPool

			for old_item in get_tree().get_nodes_in_group("items"):
				if not pool.contains(old_item.item_data):
					old_item.item_data = pool.pick_random()
					old_item.refresh_item_data()
			pewpewtimer.start(5)
		"Tealberry":
			TealberryArea.visible = true
			magnet_active = true
			tealberrytimer.start(5)

func end_pewpew_time():
	PewPewArea.visible = false
	$"Spawn Timer".wait_time = 0.75
	pool = defaultPool
	
func end_tealberry_time():
	TealberryArea.visible = false
	magnet_active = false
	
func _process(delta):
	if PewPewArea and TealberryArea:
		TealberryBar.set_value_no_signal(tealberrytimer.time_left / tealberrytimer.wait_time + 0.01)
		PewPewBar.set_value_no_signal(pewpewtimer.time_left / pewpewtimer.wait_time + 0.01)
	
	
