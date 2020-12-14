extends RigidBody2D

export var base_speed = 100
export var speed_multiplier = 1

func _ready():
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
