extends Area2D

signal hit
signal rescue

var onboard

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	onboard = 0
	
func start(pos):
	position = pos
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 2*$CollisionShape2D.shape.radius, screen_size.x - (2*$CollisionShape2D.shape.radius))
	position.y = clamp(position.y, get_parent().SURFACE_BASE, get_parent().BOTTOM_LIMIT - $CollisionShape2D.shape.radius)

func _on_Submarine_body_entered(body):
	if body.get_name().begins_with("ScubaDiver"):
		emit_signal("rescue")
	body.queue_free()
