extends Node2D

const height = 30
const width_per_size = 30
export var size = 0
var selected = false
var peg = null

func set_size(_size):
	size = _size
	var width = width_per_size * size
	$Sprite.scale.x = width
	$Sprite.scale.y = height
	$Area2D/CollisionShape2D.shape.extents = Vector2(width / 2, height / 2);
	
	# Magic color
	$Sprite.modulate = Color(1.0, 1.0 - size * 0.05, 1.0 / size)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if peg.top() == self:
			selected = true
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta);
		
func _input(event):
	# Everything it does when releasing mouse button
	if not selected:
		return
		
	if not (event is InputEventMouseButton):
		return 
		
	if event.button_index == BUTTON_LEFT and not event.pressed:
		selected = false
		var pegs = get_tree().get_nodes_in_group("pegs")
		var nearest_peg = null
		var nearest_distance = INF
		for _peg in pegs:
			var distance = abs(_peg.global_position.x - self.global_position.x)
			if distance < nearest_distance:
				nearest_peg = _peg
				nearest_distance = distance
				
		if nearest_peg.can_add_disk(self):
			peg.remove_disk()
			nearest_peg.add_disk(self)
		else:
			peg.reset_disk_position(self)
				
func reparent(parent):
	if get_parent():
		get_parent().remove_child(self)
		
	parent.add_child(self)

func set_peg(peg):
	self.peg = peg
