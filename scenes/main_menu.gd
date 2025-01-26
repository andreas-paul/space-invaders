extends Control

@onready var game = preload("res://scenes/main.tscn")

func _on_newgame_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_quit_pressed() -> void:
	get_tree().quit()
