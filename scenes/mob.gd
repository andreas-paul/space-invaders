extends CharacterBody2D
class_name Mob

@export var hitpoints : int = 1
var lowest : bool = false
@onready var bullet = preload("res://scenes/mob_bullet.tscn")


func _process(_delta: float) -> void:

	if !$RayCast2D.is_colliding():
		lowest = true
	else:
		var collider = $RayCast2D.get_collider()
		if collider is Mob:
			lowest = false
		else:
			lowest = true


func shoot(muzzle_position):
	var b = bullet.instantiate() as Area2D
	b.scale = Vector2(0.5,0.5)
	b.z_index = -1
	b.speed = 300
	b.position = muzzle_position
	owner.add_child(b)
	$SoundShoot.play()


func hit():
	$SoundExplode.play()
	$AnimatedSprite2D.visible = false
	$Sprite2D.visible = true
	await get_tree().create_timer(0.3).timeout
	Globals.enemy_destroyed.emit(1)
	queue_free()
