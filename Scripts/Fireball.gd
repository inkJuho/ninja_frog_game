extends Area2D

const SPEED = 400
var velocity = Vector2()
var direction = 1


func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("Fireball")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	if "Enemy" in body.name:
		$EnemyHit.play()
		body.dead()
	elif "Boss" in body.name:
		$BossHit.play()
		body.dead()
	#elif "Player" in body.name:
		#body.dead()
	queue_free()
