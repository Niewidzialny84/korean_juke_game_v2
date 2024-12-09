extends Area2D

@export var control_player : Player

signal picked_up_ball 
signal dropped_ball

var starting_point = Vector2.ZERO

var in_area = false
var active = false
var usable = true

func _ready() -> void:
	starting_point = position
	control_player.died.connect(reset_position)

func _process(_delta: float) -> void:
	if (in_area or active) and Input.is_action_pressed("interact") and usable:
		activate()

func activate() -> void:
	if active: 
		drop_ball()
	else:
		pick_up_ball()
	
	active = !active
	usable = false
	$Timer.start()
	

func pick_up_ball() -> void:
	control_player.getAnimatedSprite2D().animation = "player_walk_ball"
	
	visible = false
	picked_up_ball.emit()

func drop_ball() -> void:
	control_player.getAnimatedSprite2D().animation = "player_walk"
	
	visible = true
	position = control_player.position - Vector2(0, -8)
	dropped_ball.emit()

func _on_body_entered(body: Node2D) -> void:
	if body.name == control_player.name:
		in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == control_player.name:
		in_area = false

func _on_timer_timeout() -> void:
	usable = true

func reset_position() -> void:
	in_area = false
	active = false
	usable = true
	
	drop_ball()
	
	position = starting_point
