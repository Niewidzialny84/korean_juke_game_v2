extends CharacterBody2D

class_name Player

signal died 

const SPEED = 300
const JUMP_POWER = -375
var starting_position = Vector2.ZERO

@export var ball : Ball
var has_ball = false
var original_camera_zoom = Vector2.ZERO
var camera_zoom_treshold = Vector2(0.5, 0.5)

func _ready() -> void:
	original_camera_zoom = $Camera2D.zoom
	
	ball.picked_up_ball.connect(_on_ball_picked_up_ball)
	ball.dropped_ball.connect(_on_ball_dropped_ball)
	
func handle_input() -> void:
	velocity.x = 0
		
	if Input.is_action_pressed("zoom"):
		if $Camera2D.zoom >= camera_zoom_treshold:
			$Camera2D.zoom -= Vector2(0.03, 0.03)
		
		#To ignore all further movement
		return
	else:
		$Camera2D.zoom = original_camera_zoom
	
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = false
		velocity.x -= SPEED
	
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = true
		velocity.x += SPEED		
		
	if Input.is_action_just_pressed("move_up") and is_on_floor() and !has_ball:
		velocity.y = JUMP_POWER
		$JumpSound.play()
		
	if velocity.x != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if !is_on_floor():
		velocity.x /= 1.5
	
func _physics_process(_delta: float) -> void:
	if $DeathAnimation.is_playing():
		return
	
	velocity.y += get_gravity().y * _delta
	
	handle_input()
	move_and_slide()

func check_enemy_collision(body: Node2D) -> void:
	if body is EnemyAnt:
		deathFromEnemy()

func deathFromEnemy() -> void:
	if !$AnimatedSprite2D.visible:
		return
	
	$AnimatedSprite2D.hide()
	
	await get_tree().create_timer(0.2).timeout
	
	$DeathAnimation.show()
	$DeathAnimation.play()
	$DeathSound.play()
	
	await $DeathAnimation.animation_finished
	
	$DeathAnimation.hide()
	$AnimatedSprite2D.show()
	
	restart_position()

func restart_position() -> void:
	position = starting_position
	
	died.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	check_enemy_collision(body)
	
func _on_ball_dropped_ball() -> void:
	$AnimatedSprite2D.animation = "player_walk"
	has_ball = false

func _on_ball_picked_up_ball() -> void:
	$AnimatedSprite2D.animation = "player_walk_ball"
	has_ball = true
