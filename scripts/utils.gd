extends Object


static func pick_random(items):
	var index = randi() % items.size()
	return items[index]
