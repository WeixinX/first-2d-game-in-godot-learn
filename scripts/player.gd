extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 若玩家不在地板上，则添加重力
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 若按下空格键且玩家站在地板上，则跳跃
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 根据按下的方向键进行左右移动，获取输入方向：-1、0、1
	var direction := Input.get_axis("move_left", "move_right")
	
	# 翻转精灵图
	if direction > 0:
		animated_sprite_2d.flip_h = false # 向右移动，不需要翻转精灵图
	elif direction < 0:
		animated_sprite_2d.flip_h = true # 向左移动，翻转精灵图
	
	# 播放动画
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	# 移动
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
