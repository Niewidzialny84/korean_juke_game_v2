extends Control

@onready var main = $"../../"

func _return_to_menu() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _exit_game() -> void:
	get_tree().quit()
	
func _restart() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	
func _resume() -> void:
	main.pauseMenu()
