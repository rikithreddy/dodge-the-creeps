extends Area2D

var direction: Vector2
var velocity: Vector2
var animator: AnimatedSprite
onready var movementObj = PlayerMovement.new()

signal hit

func _enter_tree():
	hide()
	$AnimatedSprite.play("idle")

func animate():
	$Trail.set_emitting(true)	
	if direction.x != 0:
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v = false
	elif direction.y != 0:
		$AnimatedSprite.play("up")
		$AnimatedSprite.flip_v = direction.y > 0
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.play("idle")
		$Trail.set_emitting(false)


func get_direction():
	direction = Vector2()
	# Replace by Constants
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1		

func _physics_process(delta):
	get_direction()
	position = movementObj.movement(position, direction, delta)
	animate()

func start(pos):
	position = pos
	show()
	monitoring = true
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)

