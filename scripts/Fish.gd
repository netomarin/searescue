extends RigidBody2D

export var base_speed = 100
export var speed_multiplier = 1

func _ready():
	var fish_colors = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = fish_colors[randi() % fish_colors.size()]
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
