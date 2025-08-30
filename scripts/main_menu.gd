extends Node


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		on_quit()


func on_start() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func on_options() -> void:
	pass # Replace with function body.


func on_quit() -> void:
	get_tree().quit()
