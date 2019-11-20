extends Control

var was_pressed = false
var pressed = false
var press_position = Vector2()
var offset = Vector2()
var connected_nodes = []
var max_dist = 200
var color = Color(1,1,0,0.25)

export (PackedScene) var connection_scene 
var dir = Vector2()

func _ready():
	offset = get_node("TextureButton").rect_size / 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	if pressed:
		if !was_pressed:
			press_position = get_global_mouse_position() - rect_global_position
			was_pressed = true
			
			if get_node("../../Generator").connect_mode:
				if get_node("../../Generator").select_node == null:
					get_node("../../Generator").select_node = self
				else:
					get_node("../../Generator").connect_to_node(self)
			
		rect_global_position = get_global_mouse_position() - press_position
	else:
		for n in connected_nodes:
			var dist = (n.rect_global_position - self.rect_global_position).length()
			if dist > max_dist:
				rect_global_position = rect_global_position.linear_interpolate(
				n.rect_global_position,
				delta * 3)
			


func should_connect(node):
	if !self.connected_nodes.has(node):
		return true
	return false
	
func connect_node(node):
	if node.should_connect(self):
		node.create_connection(self)
	if should_connect(node):
		create_connection(node)

func create_connection(node):
	connected_nodes.push_back(node)
	var newConnection = connection_scene.instance()
	newConnection.target = node
	newConnection.origin = self
	$Connections.add_child(newConnection)

func _on_TextureButton_button_up():
	was_pressed = false
	pressed = false

func _on_TextureButton_button_down():
	pressed = true
