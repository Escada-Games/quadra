extends Node2D

var arrTetriminos=[
	preload("res://scenes/tetris/i-piece.tscn"),
	preload("res://scenes/tetris/o-piece.tscn"),
	preload("res://scenes/tetris/l-piece.tscn"),
	preload("res://scenes/tetris/j-piece.tscn"),
	preload("res://scenes/tetris/z-piece.tscn"),
	preload("res://scenes/tetris/s-piece.tscn"),
	preload("res://scenes/tetris/t-piece.tscn"),
]
var sfxGameStart:=preload("res://scenes/sfxGameStart.tscn")
var t=0
var strLastTetrimino:=''
var strNextTetrimino:=''
var fNextTetriminoAngle:=0.0

var bHasActiveTetrimino:=false
func _ready()->void:
	randomize()
	global.tetrisZone=self
	strNextTetrimino=arrTetriminos[randi()%arrTetriminos.size()].instance().name
	if global.iScore>=100:
		# warning-ignore:integer_division
		fNextTetriminoAngle=deg2rad(rand_range(-1,1)*10*clamp(global.iScore/200,1,3))
	var _s1=global.connect('gameStart',self,'gameStart')
	var _s2=global.connect('gameOver',self,'gameOver')
	set_process(false)

func gameOver()->void:
	bHasActiveTetrimino=true
	set_process(false)

func gameStart()->void:
	fNextTetriminoAngle=0.0
	global.add_child(sfxGameStart.instance())
	for b in $area2D.get_overlapping_bodies():
		if b is RigidBody2D:
			b.queue_free()
	self.bHasActiveTetrimino=false
	set_process(true)
	
func _process(_d)->void:
	t+=1
	if t%20==0:
		self.updatePieces()
	for c in get_children():
		if c is RigidBody2D:
			if c.bIsActive:
				bHasActiveTetrimino=true

	if not(bHasActiveTetrimino):
		global.emit_signal('newPiece')
		var i=arrTetriminos[randi()%arrTetriminos.size()].instance()
		while i.name != self.strNextTetrimino:i=arrTetriminos[randi()%arrTetriminos.size()].instance()
		i.global_position=Vector2(128,-10)
		i.rotation=fNextTetriminoAngle
		add_child(i)
		
		self.strLastTetrimino = self.strNextTetrimino
		strNextTetrimino = arrTetriminos[randi()%arrTetriminos.size()].instance().name
		if global.iScore>=100:
			# warning-ignore:integer_division
			fNextTetriminoAngle=deg2rad(rand_range(-1,1)*10*clamp(global.iScore/200,1,3))
		global.posTetriminoPreview.updateTetriminoPreview(strNextTetrimino,fNextTetriminoAngle)
#		var i=arrTetriminos[randi()%arrTetriminos.size()].instance()
#		if i.name == self.strLastTetrimino:
#			i=arrTetriminos[randi()%arrTetriminos.size()].instance()
#		i.global_position = Vector2(128,0)
#		self.strLastTetrimino = i.name
#		add_child(i)

func updatePieces():
	for b in $area2D.get_overlapping_bodies():
		if b is RigidBody2D:
			b.apply_central_impulse(Vector2(0,0))
			pass
