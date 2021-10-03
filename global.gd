extends Node

var tetrisZone
var posTetriminoPreview
var camera

#var cCurrentTetriminoColor=Color('#f07167')
#var cLineClear=Color('#fdfcdc')
var iLifes:=4 setget lifeUpdated
var iScore:=0 setget scoreUpdated
var iUnlocks:=1
var iScoreForLife:=500
var iScoreForUnlock:=100
var cLiveLost:=Color('#f07167')
var fFallSpeed:=50
var music:=preload("res://scenes/music.tscn")
var sfxNewPal:=preload("res://scenes/sfxNewPal.tscn")
var sfxGameStart:=preload("res://scenes/sfxGameStart.tscn")
var sfxSpin:= preload("res://scenes/sfxSpin.tscn")
var strCurrentPal:='Quadra'
var bInvulnerable:=false setget handleInvulnerability
func handleInvulnerability(value):
	bInvulnerable = value
	if bInvulnerable:
		get_tree().create_timer(1.0).connect("timeout",self,'makeVulnerable')
func makeVulnerable():
	self.bInvulnerable=false
	pass
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#signal lineCleared
signal gameStart
signal gameOver
signal newPiece
var bLineCleared=false
func restart():
	iLifes=4
	iScore=0
	iScoreForLife=500
	fFallSpeed=50
	emit_signal("gameStart")
	pass
func lifeUpdated(value):
	iLifes=value
	if iLifes<=0:
		emit_signal("gameOver")
		pass
	pass

func scoreUpdated(value):
	iScore=value
	if iScore>=iScoreForLife:
		iLifes+=1
		iScoreForLife*=2
	if iScore>=iScoreForUnlock:
		
		if iUnlocks<10:
			iUnlocks+=1
			strCurrentPal = 'New palette: '+dPaletteNames[iUnlocks]
		# warning-ignore:narrowing_conversion
			iScoreForUnlock+=clamp(100+(iScoreForUnlock),100,400)
			add_child(sfxNewPal.instance())
		else:
			iScoreForUnlock+=100000
	# warning-ignore:narrowing_conversion
	fFallSpeed=clamp(fFallSpeed+5,0,300)
	
var aPal1 = [ # https://coolors.co/0081a7-00afb9-fdfcdc-fed9b7-f07167
	Color('#0081A7'),
	Color('#00AFB9'),
	Color('#FDFCDC'),
	Color('#FED9B7'),
	Color('#F07167'),
]

var aPal2 = [ # https://lospec.com/palette-list/spark
	Color('#291d22'),
	Color('#4e313a'),
	Color('#9d5550'),
	Color('#f9b18e'),
	Color('#fae8bc'),
]

var aPal3 = [ # https://lospec.com/palette-list/nicole-punk-82
	Color('#faf5d8'),
	Color('#d8ae8b'),
	Color('#cd5f2a'),
		Color('#21181b'),
	Color('#f2ab37'),

]

var aPal4 = [ # https://lospec.com/palette-list/poison
	Color('#2a2a2b'),
	Color('#454a4d'),
	Color('#2f7571'),
	Color('#5a9470'),
	Color('#81b071'),
]

var aPal5 = [ # https://lospec.com/palette-list/5-sheep
	Color('#480a30'),
	Color('#b41360'),
	Color('#ff327c'),
	Color('#ff80ae'),
	Color('#ffdae8'),
]

var aPal6 = [ # https://lospec.com/palette-list/blessing
	Color('#74569b'),
	Color('#96fbc7'),
	Color('#f7ffae'),
	Color('#ffb3cb'),
	Color('#d8bfd8'),
]

var aPal7 = [ # https://lospec.com/palette-list/capp-5
	Color('#66a1ff'),
	Color('#8ecde6'),
	Color('#f0eff4'),
	Color('#6b61ff'),
	Color('#fadda2'),
]

var aPal8 = [ # https://lospec.com/palette-list/ink
	Color('#1f1f29'),
	Color('#413a42'),
	Color('#596070'),
	Color('#96a2b3'),
	Color('#eaf0d8'),
]

var aPal9 = [ # https://lospec.com/palette-list/twilight-5
	Color('#292831'),
	Color('#333f58'),
	Color('#fbbbad'),
	Color('#4a7a96'),
	Color('#ee8695'),
]

var aPal0 = [ # https://lospec.com/palette-list/neo-5
	Color('#0e0e0e'),
	Color('#e624af'),
	Color('#effafa'),
	Color('#5433be'),
	Color('#3df9ea'),
]

var dPaletteNames={
	1:'Quadra',
	2:'Spark',
	3:'Punk-82',
	4:'Poison',
	5:'5-Sheep',
	6:'Blessing',
	7:'Capp-5',
	8:'Ink',
	9:'Twilight-5',
	0:'Neo-5',
}

var aCurrentPal = aPal1

signal palChanged

func paletteChanged():
	VisualServer.set_default_clear_color(aCurrentPal[0])
	pass

func _ready()->void:
	var _s1:=self.connect("palChanged",self,'paletteChanged')
	add_child(music.instance())
	add_child(sfxSpin.instance())
	set_process(true)

func _process(_d)->void:
	if Input.is_action_just_pressed('ui_mute'):
		var idxBus:=AudioServer.get_bus_index('Master')
		AudioServer.set_bus_mute(idxBus,!AudioServer.is_bus_mute(idxBus))
	
	if Input.is_action_just_pressed("ui_pal_1"):
		aCurrentPal = aPal1
		strCurrentPal = dPaletteNames[1]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_2") and iUnlocks>1:
		aCurrentPal = aPal2
		strCurrentPal = dPaletteNames[2]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_3") and iUnlocks>2:
		aCurrentPal = aPal3
		strCurrentPal = dPaletteNames[3]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_4") and iUnlocks>3:
		aCurrentPal = aPal4
		strCurrentPal = dPaletteNames[4]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_5") and iUnlocks>4:
		aCurrentPal = aPal5
		strCurrentPal = dPaletteNames[5]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_6") and iUnlocks>5:
		aCurrentPal = aPal6
		strCurrentPal = dPaletteNames[6]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_7") and iUnlocks>6:
		aCurrentPal = aPal7
		strCurrentPal = dPaletteNames[7]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_8") and iUnlocks>7:
		aCurrentPal = aPal8
		strCurrentPal = dPaletteNames[8]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_9") and iUnlocks>8:
		aCurrentPal = aPal9
		strCurrentPal = dPaletteNames[9]
		emit_signal("palChanged")
	elif Input.is_action_just_pressed("ui_pal_0") and iUnlocks>9:
		aCurrentPal = aPal0
		strCurrentPal = dPaletteNames[0]
		emit_signal("palChanged")
	
func minorShake():
	self.camera.shake(0.2, 15, 8)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
