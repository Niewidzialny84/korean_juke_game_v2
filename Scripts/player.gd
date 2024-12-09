extends CharacterBody2D

class_name Player

signal died 

@export var Enemy : CharacterBody2D
const SPEED = 300
const JUMP_POWER = -400
var starting_position = Vector2.ZERO

@onready var pause_menu = $Camera2D/PauseMenu
var paused = false

var has_ball = false
	
func handle_input() -> void:
	velocity.x = 0
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = false
		velocity.x -= SPEED
	
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = true
		velocity.x += SPEED
		
	if Input.is_action_just_pressed("move_up") and is_on_floor() and !has_ball:
		velocity.y = JUMP_POWER
		
	if velocity.x != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if !is_on_floor():
		velocity.x /= 1.5
	
func _physics_process(_delta: float) -> void:
	velocity.y += get_gravity().y * _delta
	
	handle_input()
	move_and_slide()

func check_enemy_collision(collider_name) -> void:
	if collider_name == Enemy.name:
		restart_position()

func restart_position() -> void:
	position = starting_position
	
	died.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	check_enemy_collision(body.name)

func pauseMenu() -> void:
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	
func getAnimatedSprite2D() -> AnimatedSprite2D:
	return $AnimatedSprite2D
	
func _on_ball_dropped_ball() -> void:
	has_ball = false

func _on_ball_picked_up_ball() -> void:
	has_ball = true
