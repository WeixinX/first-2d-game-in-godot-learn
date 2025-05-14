extends Area2D

@onready var timer: Timer = $Timer
var player: CharacterBody2D = null

func _on_body_entered(body: Node2D) -> void:
	print("you died!")
	Engine.time_scale = 0.5 # 以半速运行场景
	body.get_node("CollisionShape2D").queue_free() # 移除 Player 的碰撞节点，使其下坠
	player = body
	player.set_state("death")
	timer.start() # 开始计时


func _on_timer_timeout() -> void:
	Engine.time_scale = 1 # 避免重新加载后以慢速运行
	player.set_state("idle")
	get_tree().reload_current_scene() # 获取树并重新加载当前场景
