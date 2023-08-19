extends Node2D

@export var speed = 300
var moving = true

var stunned = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stunned: return
	
	var movingVector = Vector2(Input.get_axis("Move Left", "Move Right"), 0)
	
	if not moving and movingVector.length() != 0:
		$"Ellie Sprite".play("walking")
		moving = true
		
	if moving and movingVector.length() == 0:
		$"Ellie Sprite".play("neutral")
		moving = false
		
	if movingVector.x < 0:
		scale.x = 0.25
		
	if movingVector.x > 0:
		scale.x = -0.25
	
	position += movingVector * speed * delta
	
func stun_for(duration: int):
	if not stunned:
		moving = false
		$"Ellie Sprite".scale.y = -1
		$"Ellie Sprite".play("walking")
		stunned = true
		await get_tree().create_timer(duration).timeout
		$"Ellie Sprite".scale.y = 1
		$"Ellie Sprite".play("neutral")
		stunned = false
