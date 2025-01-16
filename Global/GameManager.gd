# GameManager.gd
extends Node

@export var current_level: int = 0
@export var total_levels: int = 1
@export var lives: int = 3

signal lives_changed(new_lives)

func reset_lives():
	lives = 3

func go_to_next_level():
	current_level += 1
	if current_level <= total_levels:
		var scene_path = "res://Scenes/Levels/Level%d.tscn" % current_level
		get_tree().change_scene_to_file(scene_path)
	else:
		get_tree().change_scene_to_file("res://Scenes/UI/Victory.tscn")

func lose_life():
	lives -= 1
	emit_signal("lives_changed", lives)
	print("life lost=",lives)
	
