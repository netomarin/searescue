extends Node

export (PackedScene) var ScubaDiver
export (PackedScene) var Fish
export (PackedScene) var BlueWhale

var score
var on_board
var rescued
var screen_size
var last_enemies

const BOTTOM_LIMIT = 480
const SURFACE_BASE = 96
const ENEMY_BASE = 192

func _ready():
	randomize()
	screen_size = get_viewport().size
	$ScubaDiverTimer.start()
	$EnemyTimer.start()
	last_enemies = 0
	on_board = 0
	rescued = 0
	
func _process(delta):
	print_debug("Scuba Diver rescued: ", rescued)	
	
func _on_ScubaDiverTimer_timeout():
	var y_position = int(rand_range(SURFACE_BASE + 64, BOTTOM_LIMIT - 64))
	var position = Vector2(0, y_position)
	
	var diver = ScubaDiver.instance()
	add_child(diver)	
	diver.position = position
	diver.speed_multiplier = 2
	diver.linear_velocity = Vector2(diver.base_speed * diver.speed_multiplier, 0)

func scuba_diver_rescued():
	on_board = on_board + 1
	rescued = on_board


func _on_EnemyTimer_timeout():
	var powers = power_find(int(last_enemies))
	last_enemies = 0;
	var new_lines = randi() % (5 - powers.size()) + 1
	var line_count = 0
	while line_count < new_lines:
		var line = randi() % 5
		if !powers.has(pow(2, line)):
			last_enemies += pow(2, line)
			line_count += 1
			for c in range(randi() % 3):
				var position = Vector2(0 - (c * 128), ENEMY_BASE + (64 * line))
				var fish = Fish.instance()
				add_child(fish)
				fish.position = position
				fish.speed_multiplier = 2
				fish.linear_velocity = Vector2(fish.base_speed * fish.speed_multiplier, 0)
				fish.get_node("AnimatedSprite").flip_h = true
	
func power_find(number):
	var powers = []
	if number == 0:
		return powers
		
	var i = 1
	while i <= number:
		if i & number:
			powers.append(i)
		i <<= 1
		
	return powers
	
