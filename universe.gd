extends Node2D

var universal_gravity = 2

var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in get_children():
		bodies.push_back(x)
		
	
func _physics_process(delta):
	update()
	for x in bodies:
		for i in bodies:
			if x == i:
				continue
			var dist = (x.global_position - i.global_position).length()

			x.velocity = crossproduct(x.velocity, 
			(i.global_position - x.global_position).normalized() * universal_gravity * i.mass / pow(dist,2))
				
func crossproduct(v1, v2):
	return v1 + v2