extends Camera2D

var zoom_min = Vector2(0.20005, 0.20005)
var zoom_max = Vector2(2,2)
var zoom_speed = Vector2(0.2, 0.2)
var des_zoom = zoom
var speed = des_zoom * 5

func _process(delta):
	
	zoom = lerp(zoom, des_zoom, 0.2)
	if Input.is_action_pressed("ui_up") :
		position += Vector2(0,-9)
	if Input.is_action_pressed("ui_down") :
		position += Vector2(0,9)
	if Input.is_action_pressed("ui_left") :
		position += Vector2(-9,0)
	if Input.is_action_pressed("ui_right") :
		position += Vector2(9,0)
		

func _input(event):
	if event is InputEventMouseButton :
		if Input.is_action_pressed("scrolldown") :
			if des_zoom > zoom_min :
				des_zoom -= zoom_speed
		if Input.is_action_pressed("scrollup") :
			if des_zoom < zoom_max :
				des_zoom += zoom_speed
				




