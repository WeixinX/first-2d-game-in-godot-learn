extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point() # 碰撞硬币时，增加分数
	animation_player.play("pickup") # 碰撞硬币时，播放拾取动画及音效
