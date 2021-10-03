extends CanvasLayer
func _ready()->void:
	$textureRect.visible=true
	$tween.interpolate_property($textureRect,'modulate:a',1,0,0.6,Tween.TRANS_QUINT,Tween.EASE_IN,0.05)
	$tween.start()
	var _s1=$tween.connect("tween_all_completed",self,'queue_free')
