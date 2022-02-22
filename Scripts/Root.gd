extends Node2D

export var disk_scene: PackedScene
var default_input = "3,2,1 | 5,4 | 6"

func _ready():
	configure_form_input(default_input)

func configure_form_input(input: String):
	for peg in [$PegA, $PegB, $PegC]:
		peg.clear()
		
	var parts = input.split("|")
	for i in range(0, len(parts)):
		# GDScript only provide split_floats but not split_ints
		var sizes = parts[i].lstrip('"|').rstrip('"|').replace(" ", "").split_floats(",", false)
		for size in sizes:
			var peg = [$PegA, $PegB, $PegC][i]
			var disk = disk_scene.instance()
			disk.set_size(int(size))
			peg.add_disk(disk)
	
func _on_LineEdit_text_entered(input: String):
	configure_form_input(input)
	
