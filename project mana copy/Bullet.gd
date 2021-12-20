extends Area2D

var team_id = null
var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta
	var timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(0.25)
	timer.start()
	
	


func _on_Bullet_body_entered(body):
	if speed < 750:
		$BSprite.scale.x = -1
	if body.is_in_group("Environment"):
		queue_free()
	
	
