extends CharacterBody2D

@export var speed = 400

var target = position

func _unhandled_input(event):
	look_at(get_global_mouse_position())
	if event.is_action_pressed("l_m_b"):
		target = get_global_mouse_position()
		
func _physics_process(_delta):
	velocity = position.direction_to(target) * speed
	look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()

func _process(_delta): # every frame 
	focus_on_mouse()
	
func focus_on_mouse():
	
	
	

