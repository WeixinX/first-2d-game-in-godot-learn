extends Node2D

const SPEED = 30

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		# 撞到右墙时翻转
		direction = -1
	if ray_cast_left.is_colliding():
		# 撞到左墙时翻转
		direction = 1
	
	position.x += direction * SPEED * delta # 每次渲染在 x 轴上移动 SPEED*delta 个像素
