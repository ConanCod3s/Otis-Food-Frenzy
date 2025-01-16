# Main.gd
extends Node

signal start_game

@export var mob_scene: PackedScene
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
