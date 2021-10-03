extends Control

func _ready()->void:set_process(true)
func _process(_d:float)->void:
	if Input.is_action_just_pressed("ui_accept"):
		global.emit_signal("gameStart")
		self.goAway()
func goAway()->void:
	$twn.interpolate_property($colorRect,'modulate:a',$colorRect.modulate.a,0,0.3,Tween.TRANS_QUAD,Tween.EASE_IN,0.1)
	$twn.interpolate_property($marginCtn,'rect_global_position:y',$marginCtn.rect_global_position.y,$marginCtn.rect_global_position.y-256,0.4,Tween.TRANS_BACK,Tween.EASE_IN)
	$twn.start()
	var _s1=$twn.connect("tween_all_completed",self,'queue_free')
