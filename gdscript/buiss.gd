extends Node2D

var vide = false
@onready var sprite = $StaticBody2D/Sprite2D
@onready var sprite_vide = preload("res://sprite/buissonvide.png")
@onready var sprite_plein = preload("res://sprite/buisson.png")
var VIDE : bool = false






func _on_area_2d_area_entered(area):
	var intruderlayer = area.get_collision_layer()
	if intruderlayer == 2 :
		queue_free()
	if intruderlayer == 128 and VIDE == false :
		$Timer.start()
		$crunchsound.play()
		await $crunchsound.finished
		VIDE = true
		sprite.texture = sprite_vide




func _on_timer_timeout():
	VIDE = false
	sprite.texture = sprite_plein
	$plop.play()
	
