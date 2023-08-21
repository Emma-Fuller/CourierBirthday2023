extends Node2D

@export var speed = 300
var moving = true

var stunned = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PowerupManager.pewpewactive and $"Ellie Sprite".animation == "walking":
		$"Ellie Sprite".play("walkingpew")
	if PowerupManager.pewpewactive and $"Ellie Sprite".animation == "neutral":
		$"Ellie Sprite".play("neutralpew")
	if (not PowerupManager.pewpewactive) and $"Ellie Sprite".animation == "neutralpew":
		$"Ellie Sprite".play("neutral")
	if (not PowerupManager.pewpewactive) and $"Ellie Sprite".animation == "walkingpew":
		$"Ellie Sprite".play("walking")
	
	if stunned: return
	
	var movingVector = Vector2(Input.get_axis("Move Left", "Move Right"), 0)
	
	if not moving and movingVector.length() != 0:
		$"Ellie Sprite".play(
			"walkingpew" if PowerupManager.pewpewactive else "walking"
		)
		moving = true
		
	if moving and movingVector.length() == 0:
		$"Ellie Sprite".play(
			"neutralpew" if PowerupManager.pewpewactive else "neutral"
		)
		moving = false
		
	if movingVector.x < 0:
		scale.x = 0.25
		
	if movingVector.x > 0:
		scale.x = -0.25
	
	position += movingVector * speed * delta
	
func stun_for(duration: int):
	if not stunned:
		moving = false
		$"Ellie Sprite".play("bonk")
		stunned = true
		await get_tree().create_timer(duration).timeout
		$"Ellie Sprite".play("neutral")
		stunned = false
