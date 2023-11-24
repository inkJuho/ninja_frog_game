extends Area2D


func _ready():
	pass


func _on_BossTrigger_PlayerEntered():
	$AnimationPlayer.play("active")
	yield(get_tree().create_timer(1,3), "timeout")
	$AnimationPlayer.play("closed")
	emit_signal("isClosed")
