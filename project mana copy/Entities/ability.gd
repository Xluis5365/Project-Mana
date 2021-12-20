extends TextureButton


onready var time_label = $Value

export var cooldown = 2.0

signal Cooldown_stopped
signal Stopped

func _ready():
	time_label.hide()
	$Sweep.value = 0
	$Sweep.texture_progress = texture_normal
	$Timer.wait_time = cooldown
	set_process(false)
	connect("Cooldown_stopped", self, "SIgn")

func _process(delta):
	time_label.text = "%3.1f" % $Timer.time_left
	$Sweep.value = int(($Timer.time_left / cooldown) * 100)

func SIgn():
	emit_signal("Stopped")
	
func _on_Timer_timeout():
	print("ability ready")
	$Sweep.value = 0
	disabled = false
	time_label.hide()
	set_process(false)
	emit_signal("Cooldown_stopped")

func _on_TextureButton_pressed():
	disabled = true
	set_process(true)
	$Timer.start()
	time_label.show()
