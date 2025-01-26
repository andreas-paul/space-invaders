extends Area2D
class_name MobBullet

@export var speed = 200

func _physics_process(delta):
	position += transform.y * speed * delta


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("Player"):
		body.hit()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func hit():
	queue_free()
