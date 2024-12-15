extends Control

var paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func _return_to_menu() -> void:
	#Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _exit_game() -> void:
	get_tree().quit()
	
func _restart() -> void:
	#Engine.time_scale = 1
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _resume() -> void:
	pauseMenu()

func pauseMenu() -> void:
	if paused:
		$".".hide()
		get_tree().paused = false
		#Engine.time_scale = 1
	else:
		$".".show()
		get_tree().paused = true
		#Engine.time_scale = 0
		
	paused = !paused
