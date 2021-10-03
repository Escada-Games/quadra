extends Node2D
var t:=0
var dots:=preload("res://scenes/dots.tscn")
func _ready()->void:
	for i in range(0,264,4):
		# warning-ignore:integer_division
		var y = 4*(int(i/4)%2)
		var d=dots.instance()
		d.global_position=Vector2(i,y+10*sin(i*2*PI/264))
		add_child(d)
	set_process(true)
func _process(_d:float)->void:
	t+=1
	var idx=-1
	for c in get_children():
		var y = 4*(idx%2)-16
		c.global_position=Vector2(4*idx,y+4*sin(0.1*t-idx*2*PI*10/264))
		idx+=1
