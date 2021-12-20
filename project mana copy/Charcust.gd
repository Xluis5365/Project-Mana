extends Control

onready var Head = $Head
onready var head_name = $Head_Name
onready var body_name = $Class_Name



onready var Dummy = $Body_Classes/Body_Class1
onready var Maestro = $Body_Classes/Body_Class2
onready var Ninja = $Body_Classes/Body_Class3
onready var Painter = $Body_Classes/Body_Class4
onready var Scrapslinger = $Body_Classes/Body_Class5
onready var Sniper = $Body_Classes/Body_Class6

var Classes = 1
var headnames = ['base', 'cop', 'glass']

func _physics_process(delta):
	Head_Change()
	Classes_Change()
	print(Classes)

func Head_Change():
	if Head.frame == 0:
		head_name.text = headnames[0]
	elif Head.frame == 1:
		head_name.text = headnames[1]
	elif Head.frame == 2:
		head_name.text = headnames[2]
	else:
		head_name.text = "Choose a Head"

func Classes_Change():
	if Classes == 1:
		Dummy.visible = true
	elif Classes == 2:
		Maestro.visible = true
	elif Classes == 3:
		Ninja.visible = true
	elif Classes == 4:
		Painter.visible = true
	elif Classes == 5:
		Scrapslinger.visible = true
	elif Classes == 6:
		Sniper.visible = true
	if Classes != 1:
		Dummy.visible = false
	if Classes != 2:
		Maestro.visible = false
	if Classes != 3:
		Ninja.visible = false
	if Classes != 4:
		Painter.visible = false
	if Classes != 5:
		Scrapslinger.visible = false
	if Classes != 6:
		Sniper.visible = false
	
func _on_Left_Head_pressed():
	Head.frame -= 1


func _on_Right_Head_pressed():
	Head.frame += 1


func _on_Left_Body_pressed():
	if Classes > 1:
		Classes -= 1
func _on_Right_Body_pressed():
	if Classes <= 1:
		Classes += 1
	elif Classes <= 2:
		Classes += 1
	elif Classes <= 3:
		Classes += 1
	elif Classes <= 4:
		Classes += 1
	elif Classes <= 5:
		Classes += 1
