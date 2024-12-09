extends Node

func _change_to_game_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_screen.tscn")

func _exit_game() -> void:
	get_tree().quit()


func _on_help_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/help_screen.tscn")
