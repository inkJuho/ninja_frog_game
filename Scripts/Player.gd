extends KinematicBody2D


signal life_changed(player_hearts)

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 55
const MAX_FALL_SPEED = 964

const FIREBALL = preload("res://Scenes/Fireball.tscn")

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite


var delay = 1
var yvelo = 0
var facing_right = false

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, yvelo), Vector2(0,-1))
	
	if Input.is_action_just_pressed("ui_attack"):
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
	
	var grounded = is_on_floor()
	yvelo += GRAVITY
	if grounded and Input.is_action_just_pressed("ui_up"):
		yvelo = -JUMP_FORCE
	if grounded and yvelo >= 5:
		yvelo = 5
	if yvelo > MAX_FALL_SPEED:
		yvelo = MAX_FALL_SPEED
		
	if !facing_right and move_dir <0:
		flip()
	if facing_right and move_dir > 0:
		flip()
		
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("Walk")
	else:
		play_anim("jump")
	

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
