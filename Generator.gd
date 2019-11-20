extends Node2D

export (PackedScene) var node_scene 
var amount = 3
var nodes = []
var max_dist = 64

var connect_mode = false

var select_node


func _draw():
	if connect_mode && select_node != null:
		draw_line(select_node.rect_global_position, get_global_mouse_position(), ColorN("red"))
# Called when the node enters the scene tree for the first time.
func _ready():
	var first_node = node_scene.instance()
	get_node("../Nodes").add_child(first_node)
	var previous_node = first_node
	nodes.push_back(first_node)
	for i in amount:
		var current_node = node_scene.instance()
		current_node.connect_node(previous_node)
		previous_node = current_node
		get_node("../Nodes").add_child(current_node)
		nodes.push_back(current_node)
		if i == amount -1 :
			current_node.connect_node(first_node)
			
func _process(delta):
	update()
	if connect_mode and Input.is_action_just_pressed("ui_cancel"):
		connect_mode = false
		select_node = null
	get_node("../Label").text = "Connecting: " + str(connect_mode) 
	if select_node != null:
		get_node("../Label").text += str(select_node.name)
	for n in nodes:
		for i in nodes:
			if n == i:
				continue
			var dist = ((n.rect_global_position + n.offset)  - (i.rect_global_position + i.offset)).length()
			if dist <= max_dist:
				n.color = Color(1,0,0,0.2)
				var angle = ((i.rect_global_position )  - 
						(n.rect_global_position ) ).angle()
				var degAngle = deg2rad( rad2deg(angle) + 180)
				var dir = Vector2(cos(degAngle), sin(degAngle))
				n.dir = dir
				i.rect_global_position = i.rect_global_position.linear_interpolate(
				n.rect_global_position - dir * (max_dist - dist) ,
				delta * 1) 
			else:
				n.color = Color(1,1,0,0.2)

func select_node(node):
	if select_node != node:
		select_node = node

func connect_to_node(node):
	if select_node != null and select_node != node:
		select_node.connect_node(node)
	select_node = node

func _on_PopupMenu_id_pressed(ID):
	if ID == 0:
		var current_node = node_scene.instance()
		current_node.rect_global_position = get_global_mouse_position()
		get_node("../Nodes").add_child(current_node)
		nodes.push_back(current_node)
	if ID == 1:
		connect_mode = true