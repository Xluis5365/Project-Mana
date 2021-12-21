extends KinematicBody2D
#varibles wil be changed later for stats system
const UP = Vector2(0,-1)
var GRAVITY = 20
var MAXFALLSPEED = 500
var MAXSPEED = 290
var JUMPFORCE = 425
var ACCEL = 50
var DASHSPD = 1750
var DBLJUMP = true
var motion = Vector2()
var facing_right = true
export (bool) var animation_locked = false
export(int) var hp_max: int = 100
export(int) var hp: int = hp_max
export(int) var defense: int = 0
var Bullet = preload("res://Bullet.tscn")
var cooldown = true

onready var time_label = $TextureRect/Value


func _ready() -> void:
	self.position = Global.spawn_point
	var Number_Receiver = get_tree().get_root().find_node("Charcust", true, false)
	Number_Receiver.connect("Char_Settings", self, "Handle_Charcust")

func Handle_Charcust(Class_number, head_number):
	print(Class_number)
	print(head_number)

	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right:
		$Body_Sel_Classes.scale.x = 1
	else:
		$Body_Sel_Classes.scale.x = -1
	
	motion.x = clamp(motion.x, -MAXSPEED,MAXSPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
		if animation_locked == false:
			$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right = false
		if animation_locked == false:
			$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x,0,0.3)
		if Input.is_action_pressed("down"):
			if animation_locked == false:
				$AnimationPlayer.play("crouch")
		else:
			if animation_locked == false:
				$AnimationPlayer.play("Idle")

	if is_on_floor() || DBLJUMP:
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
			DBLJUMP = false
	if is_on_wall():
		MAXFALLSPEED = 50
		DBLJUMP = true
	elif is_on_floor() and DBLJUMP == false:
		DBLJUMP = true
	else:
		MAXFALLSPEED = 500

	if !is_on_floor():
		if motion.y  < 0:
			if animation_locked == false:
				$AnimationPlayer.play("Rise")
		elif motion.y > 0:
			if animation_locked == false:
				$AnimationPlayer.play("fall")
	if !is_on_floor() and Input.is_action_pressed("Stop_time") and cooldown == false:
		$Camera2D/TextureButton.emit_signal("pressed")
		motion.x = 0
		motion.y = 0
		GRAVITY = 0
		$AnimationPlayer.play("dodge")
	elif Input.is_action_just_released("Stop_time"):
		cooldown = true
		GRAVITY = 20
	if Input.is_action_just_pressed("dash"):
		die()
	
	if Input.is_action_just_pressed("Basic attack"):
		battack()

	
	
	
	
	motion = move_and_slide(motion,UP)
	
func die():
	var timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "respawn")
	timer.set_wait_time(5)
	timer.set_one_shot(true)
	timer.start()
	
func respawn():
	self.position = Global.spawn_point

func battack():
	animation_locked = true
	$AnimationPlayer.play("Batk")
	var b = Bullet.instance()
	owner.add_child(b)
	if facing_right:
		b.transform = $Position2D.global_transform
	elif !facing_right:
		b.transform = $Position2D2.global_transform
		b.speed *= -1
	

func _on_AnimationPlayer_animation_finished(Batk) -> void:
	animation_locked = false










func _on_TextureButton_Stopped():
	cooldown = false
	print("it does stop")
