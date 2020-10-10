class_name PlayerMovement

var SPEED = 400
var screen_size: Vector2 = GameVariables.SCREEN_DIMENSIONS

func _ready():
	pass # Replace with function body.


func movement(position, direction, delta):
	if direction.length() > 0:
		position += direction.normalized() * SPEED * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 96, screen_size.y)
	print(position)
	return position
