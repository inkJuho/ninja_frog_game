extends KinematicBody2D


signal life_changed(player_hearts)

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 55
const MAX_FALL_SPEED = 964

const FIREBALL = preload("res://Scenes/Fireball.tscn")

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

export(int) var Hp = 1
var velocity = Vector2()
var delay = 1
var yvelo = 0
var facing_right = false
var is_dead = false
var lives = 300

func _physics_process(delta):
	if is_dead == false or lives <= 1:
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
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" and "Boss" in get_slide_collision(i).collider.name:
					dead()

func dead():
	Hp = Hp - 1
	_ready()
	if Hp <= 0:
		is_dead = true
		velocity = Vector2(0, 0)
		$AnimationPlayer.play("dead")
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Timer.start()

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	



func _on_HUD_ready():
	dead()


func _on_BossTrigger_PlayerEntered():
	pass # Replace with function body.
