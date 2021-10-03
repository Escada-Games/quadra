extends Position2D
func _ready()->void:global.posTetriminoPreview=self
func updateTetriminoPreview(strName,fAngle)->void:
	for c in get_children():c.queue_free()
	var i = load('res://scenes/tetris/'+strName+'.tscn').instance()
	#i.global_position=self.global_position
	i.position=Vector2()
	i.bDisplayOnly=true
	i.rotation=fAngle
	add_child(i)
	
