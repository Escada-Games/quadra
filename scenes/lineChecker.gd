extends Area2D
var lineClearFx:=preload("res://scenes/lineFx.tscn")
var sfxLineClear1:=preload("res://scenes/sfxLineClear1.tscn")
var sfxLineClear2:=preload("res://scenes/sfxLineClear2.tscn")
var iTetriminos:=0
const iLineSize = 10
func _ready()->void:
	var _s1=global.connect("newPiece",self,'_on_timer_timeout')
	var _s2=self.connect("area_entered",self,'checkLine')
	var _s3=self.connect("area_exited",self,'removeCounter')
	set_process(false)
func removeCounter(area):
	if area.is_in_group('TetriminoPiece'):iTetriminos=max(0,iTetriminos-1)
func checkLine(area):
	if area.is_in_group('TetriminoPiece'):
#		if !area.get_parent().get_parent().bIsActive:
		iTetriminos+=1
#	if self.name=='0':
#		print(iTetriminos)
	if iTetriminos>=iLineSize:
		var iLocalCounter=0
		for n in get_overlapping_areas():
			if n.is_in_group('TetriminoPiece'):
				iLocalCounter+=1
		print(iLocalCounter)
		if iLocalCounter<iLineSize:
			iTetriminos=iLocalCounter
			return
			clearLine()

	pass
func clearLine():
	global.bLineCleared=true
	var i=lineClearFx.instance()
	i.global_position=Vector2()
	add_child(i)
	global.minorShake()
	global.iScore+=100
	global.add_child(sfxLineClear1.instance())
	global.add_child(sfxLineClear2.instance())
	for a in get_overlapping_areas():
		a.deleteSelf()
	global.bLineCleared=false
	iTetriminos=0#self.get_overlapping_areas().size()
	global.tetrisZone.updatePieces()
	pass

func checkLineOld(_a:Area2D=Area2D.new())->void:
	var iCounter:=0
	if not global.bLineCleared:
		for n in get_overlapping_areas():
			if n.is_in_group('TetriminoPiece'):
	#			iCounter+=1
				if n.get_parent().get_parent().linear_velocity.length()<1:
					iCounter+=1
			if iCounter>=iLineSize:
				global.bLineCleared=true
				print(iCounter)
				var i=lineClearFx.instance()
				i.global_position=Vector2()
				add_child(i)
				global.minorShake()
				global.iScore+=100
				global.add_child(sfxLineClear1.instance())
				global.add_child(sfxLineClear2.instance())
				for a in get_overlapping_areas():
					a.deleteSelf()
				global.bLineCleared=false
			global.tetrisZone.updatePieces()
			
func _process(_d)->void:
	if not global.tetrisZone.bHasActiveTetrimino:
		var iTetriminos = get_overlapping_areas().size() -1
		if iTetriminos >= iLineSize:
			print(iTetriminos)
			var i=lineClearFx.instance()
			i.global_position=Vector2()
			add_child(i)
			global.minorShake()
			global.iScore+=100
			global.add_child(sfxLineClear1.instance())
			global.add_child(sfxLineClear2.instance())
			for a in get_overlapping_areas():
				a.deleteSelf()
		global.tetrisZone.updatePieces()


func _on_timer_timeout():
	var iLocalCounter=0
	for n in get_overlapping_areas():
		if n.is_in_group('TetriminoPiece'):
			iLocalCounter+=1
	if iLocalCounter>=iLineSize:
		iTetriminos=iLocalCounter
		clearLine()
