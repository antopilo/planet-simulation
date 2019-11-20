extends Sprite

export(float) var mass = 200

export var velocity = Vector2(1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = position + (velocity * delta)
	update()
	
#func _draw():
	#draw_line(Vector2(), velocity * 25, ColorN("red")) 