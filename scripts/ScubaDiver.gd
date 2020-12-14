extends RigidBody2D

export var base_speed = 100
export var speed_multiplier = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = false

func _on_VisibilityNotifier2D_screen_exited():
	print_debug("_on_VisibilityNotifier2D_screen_exited")
	queue_free()
