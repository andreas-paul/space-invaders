extends CharacterBody2D

@export var speed = 100
@onready var bullet = preload("res://scenes/bullet.tscn")
var hitpoints = 3
var allow_shooting : bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		if allow_shooting:
			shoot()

	velocity.x = Input.get_axis("ui_left", "ui_right") * speed
	move_and_slide()


func shoot():
	allow_shooting = false
	var b = bullet.instantiate()
	b.transform = $Muzzle.global_transform
	$AudioStreamPlayer2D.play()
	owner.add_child(b)
		

func hit():
	$SoundHit.play()
	await $SoundHit.finished
	hitpoints -= 1
	Globals.player_lost_life.emit()
	
	if hitpoints <= 0:
		$SoundDeath.play()
		$Sprite2D.region_rect = Rect2(64, 0, 32, 16)
		await $SoundDeath.finished
		queue_free()
		Globals.player_death.emit()
	else:
		$Sprite2D.region_rect = Rect2(32, 0, 32, 16)
	

	

func _on_timer_timeout() -> void:
	allow_shooting = true
