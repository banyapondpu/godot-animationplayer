extends KinematicBody2D

var input_direction = 0
var direction = 0
var speed = 0
var velocity = 1

const MAX_SPEED = 600
const ACCELERATION = 1000
const DECELERATION = 2000
const JUMP_FORCE = 20.0

var anim_play
var anim = ""
var anim_new = ""

func _ready():
	set_process(true)
	anim_play = get_node("AnimationPlayer")
	pass

func _process(delta):
	move( Vector2(0,10))
	
	if input_direction:
		direction = input_direction
		
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
		set_scale(Vector2(-1,1))
		print("walk")
		anim = "walk"
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		set_scale(Vector2(1,1))
		print("walk")
		anim = "walk"
	else:
		input_direction = 0
		anim = "idle"
		print("idle")
	
	if anim != anim_new:
		anim_new = anim
		anim_play.play(anim)
	
	pass

	
	# MOVEMENT
	if input_direction == - direction:
		speed /= 3

	if input_direction:
		speed += ACCELERATION * delta
	else:
		speed -= DECELERATION * delta

	speed = clamp(speed, 0, MAX_SPEED)	
	velocity = speed * delta * direction
	move(Vector2(velocity, 0))
	
	#JUMP
	if Input.is_action_pressed("ui_up"):
		move(Vector2(0, -JUMP_FORCE))
	pass