extends Node


func on_continue() -> void:
	queue_free()


func on_options() -> void:
	pass # Replace with function body.


func on_quit() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
