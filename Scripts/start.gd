extends Area2D

@export var control_player : Player

func _ready() -> void:
	control_player.starting_position = position
	control_player.restart_position()
