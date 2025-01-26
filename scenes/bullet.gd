extends Area2D

@export var speed = -500

func _physics_process(delta):
	position += transform.y * speed * delta


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("Mobs"):
		body.hit()
	queue_free() 


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is MobBullet:
		area.hit()
	queue_free() 
