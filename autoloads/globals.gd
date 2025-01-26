extends Node

signal score
signal enemy_destroyed(int)
signal life_lost
signal player_lost_life
signal player_death
signal player_won


var player_score = 0
var player_life = 3

func _ready() -> void:
	player_lost_life.connect(_on_life_lost)
	enemy_destroyed.connect(_on_enemy_destroyed)

func _on_life_lost():
	player_life -= 1
	life_lost.emit()
	
func _on_enemy_destroyed(point: int):
	player_score += point
	score.emit()
