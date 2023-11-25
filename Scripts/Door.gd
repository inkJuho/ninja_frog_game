extends StaticBody2D

signal isClosed

func _on_Trigger_PlayerEntered():
	$BossMusic.play()
	$AnimationPlayer.play("active")
	$BossMusic.play()
	yield(get_tree().create_timer(1,3), "timeout")
	$AnimationPlayer.play("closed")
	emit_signal("isClosed")
	$BossMusic.play()
