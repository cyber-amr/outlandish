extends Node
class_name MainMenu


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		on_exit()


func on_start() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func on_options() -> void:
	pass # Replace with function body.


func on_exit() -> void:
	get_tree().quit()
