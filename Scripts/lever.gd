extends Area2D

@export var sprite_frame : SpriteFrames
@export var controled_blocks : TileMapLayer
@export var control_player : Player

signal leverSwitch

var in_area = false
@export var active = true
var usable = true

func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = sprite_frame

func _process(_delta: float) -> void:
	if in_area and Input.is_action_pressed("interact") and usable and !control_player.has_ball:
		activate()

func activate() -> void:
	active = !active
	usable = false
	$AnimatedSprite2D.set_frame(!active)
	$Timer.start()
	$AudioStreamPlayer.play()
	
	controled_blocks.visible = active
	controled_blocks.collision_enabled = active
	
	leverSwitch.emit()

func _on_body_entered(body: Node2D) -> void:
	if body.name == control_player.name:
		in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == control_player.name:
		in_area = false


func _on_timer_timeout() -> void:
	usable = true
