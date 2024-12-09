extends RichTextLabel


func _ready() -> void:
	scroll_text()
	
func scroll_text() -> void:
	visible_characters = 0
	
	for i in get_parsed_text():
		visible_characters += 1
		await get_tree().create_timer(0.1).timeout
		
	await get_tree().create_timer(5).timeout
	
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
