extends Area2D

@export var control_player : Player
@export var max_level : int = 2

func _on_body_entered(body: Node2D) -> void:
	if body.name != control_player.name:
		return

	if control_player.has_ball:
		#TODO: some effects for winning
		
		switch_to_next_scene()
		

func switch_to_next_scene() -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	if current_scene_file.to_int() == max_level:
		get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")
		return
	
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = "res://Scenes/Levels/Level" + str(next_level_number) + ".tscn"
	
	get_tree().change_scene_to_file(next_level_path)
