extends KinematicBody2D

const GRAVITY = 10
const SPEED = 200
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1

export(int) var hp = 1

var is_dead = false

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


func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		
		$AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
		

		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1

func _on_Timer_timeout():
	queue_free()

