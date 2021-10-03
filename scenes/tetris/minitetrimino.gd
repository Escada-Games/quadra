extends CollisionShape2D
var t=0
var minitetriminoFx = preload("res://scenes/tetris/tetriminoFx.tscn")


func _ready()->void:
	$line2D.set_as_toplevel(true)
	$line2D.clear_points()
	set_process(false)
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors():
	$line2D.modulate=global.aCurrentPal[2]

func getIntoMainLayer():
	#$area2D.set_collision_layer_bit(3,true)
	#$area2D.set_collision_mask_bit(3,true)
	$area2D.add_to_group('TetriminoPiece')
	for n in $area2D.get_overlapping_areas():
		if n.is_in_group('LineChecker'):
			n.iTetriminos+=1
	pass

func _process(_d)->void:
	t+=1
	if t>2:
		if $line2D.get_point_count()>00:
			$line2D.remove_point(0)
		else:
			set_process(false)
		
	pass

func removeWhiteOutline():
	$sprBgWhite.queue_free()

func updateLine():
	$line2D.add_point($line2D.to_local(self.global_position))
	if $line2D.get_point_count()>24:$line2D.remove_point(0)
#	$line2D2.add_point($line2D2.to_local(self.global_position))
#	if $line2D2.get_point_count()>64:$line2D2.remove_point(0)
func deleteLine():
	if $line2D.get_point_count()>0:
		$line2D.remove_point(0)
		yield(get_tree().create_timer(0.02),"timeout")
		deleteLine()

func deleteSelf():
	get_parent().bIsActive=false
	get_parent().get_parent().bHasActiveTetrimino=false
	var i=minitetriminoFx.instance()
	i.global_position=self.global_position
	i.global_rotation=self.global_rotation
	#get_parent().get_parent().add_child(i)
	get_parent().get_parent().call_deferred('add_child',i)
	self.queue_free()
	pass
	
