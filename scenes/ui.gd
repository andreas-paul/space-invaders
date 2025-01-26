extends Control

@onready var score_label = $ColorRect/MarginContainer/HBoxContainer/ScoreLabel
@onready var lifes_label = $ColorRect2/MarginContainer/HBoxContainer/LifesLabel


func _ready() -> void:
	Globals.score.connect(_on_score)
	Globals.life_lost.connect(_on_life_lost)
	Globals.player_death.connect(_on_player_death)
	Globals.player_won.connect(_on_player_won)
	lifes_label.text = str(Globals.player_life)

func _on_score():
	score_label.text = str(Globals.player_score)
	

func _on_life_lost():
	lifes_label.text = str(Globals.player_life)

func _on_player_death():
	$ColorRect. visible = false
	$ColorRect2.visible = false
	$GameOverScreen.visible = true
	get_tree().paused = true
	
func _on_player_won():
	$ColorRect. visible = false
	$ColorRect2.visible = false
	$PlayerWonScreen.visible = true
	get_tree().paused = true
