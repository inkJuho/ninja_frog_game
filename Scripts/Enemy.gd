extends KinematicBody2D

const GRAVITY = 10
export(int) var SPEED = 50
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1

var is_dead = false

export(int) var hp = 1

func _ready():
	pass

func dead():
	hp = hp - 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Timer.start()

func ouch(var enemyposx):
	Global.lose_life()
	
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
		
	Input.action_release("ui_left")
	Input.action_release("ui_right")


func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
	
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		
	if get_slide_count() > 0:
		for i in range (get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()



func _on_Timer_timeout():
	queue_free()


