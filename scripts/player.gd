extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ROLL_SPEED = 400
const ROLL_DURATION = 0.8 # 8 * 10/1000，8 是 roll 的动画帧数，10/1000 是 10 FPS

enum PlayerState {IDLE, RUN, JUMP, ROLL, DEATH}

var state = PlayerState.IDLE
var roll_time = 0 
var rolling = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	update_state()
	
	match state:
		PlayerState.IDLE:
			handle_idle()
		PlayerState.RUN:
			handle_run()
		PlayerState.JUMP:
			handle_jump()
		PlayerState.ROLL:
			handle_roll(delta)
		PlayerState.DEATH:
			handle_death()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()

# TODO
func update_state():
	pass

func is_jump():
	return Input.is_action_pressed("jump") and is_on_floor()	

func handle_idle():
	animated_sprite.play("idle")
	velocity.x = 0
	
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state = PlayerState.RUN
	elif is_jump():
		state = PlayerState.JUMP
	elif Input.is_action_pressed("roll"):
		state = PlayerState.ROLL

func handle_run():
	animated_sprite.play("run")
	
	if Input.is_action_pressed("move_left"):
		animated_sprite.flip_h = true
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		animated_sprite.flip_h = false
		velocity.x = SPEED
	else:
		state = PlayerState.IDLE
		
	if is_jump():
		state = PlayerState.JUMP
	elif Input.is_action_pressed("roll"):
		state = PlayerState.ROLL
	
func handle_jump():
	animated_sprite.play("jump")
	velocity.y = JUMP_VELOCITY
	state = PlayerState.IDLE # 否则会一直飞
	

# 简单实现了下 roll
func handle_roll(delta: float):
	if !rolling:
		animated_sprite.play("roll")
		rolling = true
	else:
		roll_time += delta
		if roll_time >= ROLL_DURATION:
			rolling = false
			state = PlayerState.IDLE
			roll_time = 0
			
func handle_death():
	animated_sprite.play("death")
	
func set_state(s: String):
	match s:
		"idle":
			state = PlayerState.IDLE
		"death":
			state = PlayerState.DEATH
			
