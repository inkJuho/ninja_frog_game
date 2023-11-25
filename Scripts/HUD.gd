extends CanvasLayer

var Hp = 20

func _ready():
	$Traveler.play()
	#$Counter.text = String(Hp)
	#load_hearts()
	#Global.hud = self

#f#unc _physics_process(delta):
	#if Hp == 0:
		#get_tree().change_scene("res://Scenes/Game Over.tscn")

#func _on_hp_loss():
	#Hp = Hp - 1
	#_ready()



#func load_hearts():
	#$HeartsFull.rect_size.x = Global.lives * 16
	#$HeartsEmpty.rect_size.x = (Global.max_lives -Global.lives) * 16
	#$HeartsEmpty.rect_position.x = $HeartsFull.rect_position.x + $HeartsFull.rect_size.x * $HeartsFull.rect_scale.x


func _on_BossTrigger_PlayerEntered():
	$Traveler.stop()
