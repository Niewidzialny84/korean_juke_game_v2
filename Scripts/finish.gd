extends Area2D

@export var control_player : Player
@export var end_scene : Node2D


func _on_body_entered(body: Node2D) -> void:
	if body.name != control_player.name:
		return
		
	if control_player.has_ball:
		get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")
