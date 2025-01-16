# HUD.gd
extends CanvasLayer

func _ready() -> void:
	# Connect to signal when the HUD is ready
	$LivesLabel.text = "Lives: %d" % GameManager.lives
	GameManager.connect("lives_changed", Callable(self, "_on_lives_changed"))
	# Initialize label text to current lives (in case game starts mid-level)
	#_update_lives_label(GameManager.lives)


func _on_lives_changed(new_lives):
	# This function is called automatically whenever lives change
	_update_lives_label(new_lives)


func _update_lives_label(new_lives):
	$LivesLabel.text = "Lives: %d" % new_lives
