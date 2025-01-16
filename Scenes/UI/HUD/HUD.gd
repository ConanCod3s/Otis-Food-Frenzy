# HUD.gd
extends CanvasLayer

func _ready() -> void:
	# Connect to signal when the HUD is ready
	$LivesLabel.text = "Lives: %d" % GameManager.lives
	GameManager.connect("lives_changed", Callable(self, "_on_lives_changed"))

func _on_lives_changed(new_lives):
	_update_lives_label(new_lives)

func _update_lives_label(new_lives):
	$LivesLabel.text = "Lives: %d" % new_lives
