# MainMenu.gd
extends CanvasLayer

### ------------------------------------
## This is old code from the Godot tutorial, will need to update when Gameover is working
#
#func show_message(text):
	#$Message.text = text
	#$Message.show()
	#$MessageTimer.start()
#
#func show_game_over():
	#show_message("Game Over")
	## Wait until the MessageTimer has counted down.
	#await $MessageTimer.timeout
#
	#$Message.text = "Dodge the Creeps!"
	#$Message.show()
	## Make a one-shot timer and wait for it to finish.
	#await get_tree().create_timer(0.5).timeout
	#$StartButton.show()
### ------------------------------------

func _on_start_button_pressed():
	$Message.text = "Stop the burgers!"
	await get_tree().create_timer(1.0).timeout
	$StartButton.hide()
	$Message.hide()
	GameManager.go_to_next_level();

func _on_message_timer_timeout() -> void:
	$Message.hide()
