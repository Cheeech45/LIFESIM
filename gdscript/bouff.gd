extends CharacterBody2D

var speed = 4000
@onready var nav := $NavigationAgent2D as NavigationAgent2D
var done = false
var faimf = 20
@onready var size = $Area2D/CollisionShape2D.shape.radius
@onready var randompos = Vector2(0, 0)
var buissonenvu = null


func _ready():
	$GPUParticles2D.emitting = true
	$Label.text = ("faimf : " + str(faimf))
	$Label.visible = false

func _physics_process(delta) :
	$Label.text = ("faimf : " + str(faimf))
	
#if target not reached, move to the target
	if done == false :
		
		var dir = to_local(nav.get_next_path_position()).normalized()
		var spd = speed * delta
		velocity = dir * spd
		move_and_slide()


func path() :
#set the destination if reachable, or make a new one
	if buissonenvu != null and faimf <= 10 :
		nav.target_position = buissonenvu
	else :
		nav.target_position = randompos
	if !nav.is_target_reachable() :
		movement()


func _on_navigation_agent_2d_navigation_finished():
#target reached
	done = true


func _on_timer_timeout():
	movement()
	
#make bouff hungry, and kill them if they are too much hungry
	faimf -= 1
	print(faimf)
	if faimf <= 0 :
		$death.play()
		await $death.finished
		queue_free()
	
func movement() :
#set a random position
	done = false
	var areaCentre = position
	randompos.x = (randi_range(-size, size) + areaCentre.x)
	randompos.y = (randi_range(-size, size) + areaCentre.y)
	path()


func _on_area_2d_area_entered(area):
#eat bushes's fruits if not empty
	if area.get_parent().VIDE == false :
		buissonenvu = area.get_parent().position

func _on_mouse_entered():
	$Label.visible = true

func _on_mouse_exited():
	$Label.visible = false





func _on_zonebouffage_body_entered(body):
	if body.owner.VIDE == false :
		faimf += 5
		buissonenvu = null
	else :
		buissonenvu = null


