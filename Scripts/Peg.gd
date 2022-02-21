extends Node2D

func add_disk(disk):
	var disks = $DiskContainer.get_children()
	disk.reparent($DiskContainer)
	disk.set_peg(self)
	reset_disk_position(disk)

	
func reset_disk_position(disk):
	var disks = $DiskContainer.get_children()
	if not (disk in disks):
		return
	
	var bottom = global_position.y + $Sprite.scale.y / 2
	disk.global_position.y = bottom - disk.height * (disks.size() - 1) - disk.height / 2
	disk.global_position.x = global_position.x
	
	
func can_add_disk(disk) -> bool:
	if top() == null:
		return true
	else:
		var top_disk = top()
		return disk.size < top_disk.size
	
func top():
	var disks = $DiskContainer.get_children()
	if disks.size() == 0:
		return null
	else:
		return disks.back()

func remove_disk():
	$DiskContainer.remove_child(top())
	
func clear():
	for disk in $DiskContainer.get_children():
		$DiskContainer.remove_child(disk)
		disk.queue_free()
