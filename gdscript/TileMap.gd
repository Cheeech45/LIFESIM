extends TileMap

@export var altitude = FastNoiseLite.new()
var mapx = 400
var mapy = 200
var moist = FastNoiseLite.new()
@export var tree = preload("res://scene/tree.tscn")
@export var buiss = preload("res://scene/buiss.tscn")
@export var bouff = preload("res://scene/bouff.tscn")


func generate():
	for x in range(mapx) :
		for y in range(mapy) :
			
#generate terrain and grass
			var map = altitude.get_noise_2d(x, y) * 10
			var lel = Vector2i(0,round(map+10)/2.5)
			var grassgen = moist.get_noise_2d(x, y) * 10
			var sprite = Vector2i(0,0)
			set_cell(0, Vector2i(x,y), 1, lel, 0 )
			if grassgen > 0 and lel.y <= 2 :
				$grass.set_cell(0, Vector2i(x,y), 1, sprite, 0 )
			randomize()
#generate tree based on the altitude
			var tree_proba = randf()
			if lel.y <= 2 and tree_proba >= 0.99 :
				
				var tree_spawn = tree.instantiate()
				$treeplacer.add_child(tree_spawn)
				tree_spawn.position = Vector2i(x*16+8,y*16+8 )
				
			
#generate bushes based on the altitude
			var buiss_proba = randf()
			if lel.y <= 2 and buiss_proba >= 0.994 :
				
				var buiss_spawn = buiss.instantiate()
				$buissplacer.add_child(buiss_spawn)
				buiss_spawn.position = Vector2i(x*16+8,y*16+8 )


func _ready():
#generate terrain and randomize the seeds
	
	altitude.seed = randi()
	moist.seed = randi()
	generate()

func _input(event):
	if Input.is_action_just_pressed("ui_accept") :
#randomize and erase the tilemap + grass
		altitude.seed = randi()
		moist.seed = randi()
		clear()
		$grass.clear()
#destroy trees
		var killtree = $treeplacer.get_children()
		for child in killtree :
			$treeplacer.remove_child(child)
			child.queue_free()
#destroy bushes
		var killbuiss = $buissplacer.get_children()
		for child in killbuiss :
			$buissplacer.remove_child(child)
			child.queue_free()
#destroy bouffs
		var killbouff = $bouffplacer.get_children()
		for child in killbouff :
			$bouffplacer.remove_child(child)
			child.queue_free()
			
		generate()
	
	if Input.is_action_just_released("leftclick") :
#click to generate a bouff
		var bouff_spawn = bouff.instantiate()
		$bouffplacer.add_child(bouff_spawn)
		bouff_spawn.position = get_global_mouse_position()
		
