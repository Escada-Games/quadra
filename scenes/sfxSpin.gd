extends AudioStreamPlayer

func _ready():
	self.volume_db=-100
	set_process(true)
func _process(delta):
	self.volume_db = -15 if Input.is_action_pressed("ui_spin_cc") or Input.is_action_pressed("ui_spin_cw") else -100
