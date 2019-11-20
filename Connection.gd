extends Node2D

var target = null
var origin = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Line2D.add_point(Vector2(32,32))
	$Line2D.add_point(Vector2(0,0))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Line2D.points[$Line2D.points.size() - 1] = (target.rect_global_position - origin.rect_global_position) + Vector2(32,32)
