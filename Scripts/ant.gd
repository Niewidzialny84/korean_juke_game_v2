extends CharacterBody2D

class_name EnemyAnt

const SPEED = 35.0

func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += get_gravity().y * _delta
		
	if is_on_wall():
		$Timer.timeout.emit()
		$Timer.start()
	
	if !$AnimatedSprite2D.flip_h:
		velocity.x = SPEED;
	else:
		velocity.x = -SPEED

	move_and_slide()

func flip_ant() -> void:
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
