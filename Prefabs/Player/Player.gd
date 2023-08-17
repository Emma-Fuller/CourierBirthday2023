extends Node2D

@export var speed = 300
var moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movingVector = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		0
	)
	
	if not moving and movingVector.length() != 0:
		$AnimatedSprite.play("walking")
		moving = true
		
	if moving and movingVector.length() == 0:
		$AnimatedSprite.play("neutral")
		moving = false
		
	if movingVector.x < 0:
		scale.x = 0.25
		
	if movingVector.x > 0:
		scale.x = -0.25
	
	position += movingVector * speed * delta
