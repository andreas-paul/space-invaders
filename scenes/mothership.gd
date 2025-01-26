extends CharacterBody2D

var hitpoints = 5
var travel_allowed = false
var min_speed = 40
var max_speed = 150
var speed = 200
var travel_left = false

func _process(delta: float) -> void:
	if travel_allowed:
		global_position.x = global_position.x + speed * delta
		if global_position.x >= 500:
			speed = randi_range(min_speed, max_speed) * -1
		if global_position.x <= -500:
			speed = randi_range(min_speed, max_speed)

			
func hit():
	hitpoints -= 1 
	
	if hitpoints == 3:
		$Sprite2D.region_rect = Rect2(32, 0, 32, 16)
	
	elif hitpoints <= 0:
		$Sprite2D.region_rect = Rect2(64, 0, 32, 16)
		await get_tree().create_timer(0.5).timeout
		Globals.enemy_destroyed.emit(10)
		$SoundExplode.play()
		queue_free()


func _on_timer_timeout() -> void:
	travel_allowed = true
