extends Node2D

@onready var mob = preload("res://scenes/mob.tscn")

var mobs : Array
var step_size = 8
var direction = "right"
var previous_direction : String
var grid_width = 216
var grid_height = 256
var max_timer_interval = 0.5  # Slowest movement speed
var min_timer_interval = 0.1  # Fastest movement speed


func _ready() -> void:
	$Timer.wait_time = max_timer_interval
	
func _process(delta: float) -> void:
	mobs = $Mobs.get_children()
	if mobs.size() <= 0:
		Globals.player_won.emit()


func _on_timer_timeout() -> void:
	
	mobs = $Mobs.get_children()

	# Move aliens
	move_aliens()

	# Activate shooting for individual mobs
	for child in $Mobs.get_children():
		if child is Mob:
			var _rand = randf_range(-1,1)
			if _rand > 0.9:
				if child.lowest:
					child.shoot(child.get_node("Muzzle").global_position) 

func move_aliens():

	if direction == "right":
		move_aliens_right()
		if reached_right_boundary():
			previous_direction = "right"
			direction = "down"
	elif direction == "left":
		move_aliens_left()
		if reached_left_boundary():
			previous_direction = "left"
			direction = "down"
	elif direction == "down":
		move_aliens_down()
		#adjust_speed_based_on_y_position()
		direction = "left" if previous_direction == "right" else "right"
	
	
func move_aliens_right():
	for alien in mobs:
		alien.global_position.x += step_size		

func move_aliens_left():
	for alien in mobs:
		alien.global_position.x -= step_size		
		
func move_aliens_down():
	for alien in mobs:
		alien.global_position.y += step_size	
			
func reached_right_boundary():
	var rightmost_position : int = 0
	for alien in mobs:
		rightmost_position = max(rightmost_position, alien.global_position.x)
	return rightmost_position + step_size >= grid_width

func reached_left_boundary():
	var leftmost_position : int = 9999
	for alien in mobs:
		leftmost_position = min(leftmost_position, alien.global_position.x)
	return leftmost_position - step_size <= 0

func adjust_speed_based_on_y_position():
	var max_y_position = 0
	for alien in mobs:
		max_y_position = max(max_y_position, alien.global_position.y)
	var y_ratio = max_y_position / float(grid_height) 
	var new_time = lerp(max_timer_interval, min_timer_interval, y_ratio)
	$Timer.wait_time = new_time if new_time > 0 else min_timer_interval
