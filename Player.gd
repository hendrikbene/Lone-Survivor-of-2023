extends CharacterBody2D

@export var speed = 400

var screen_size: Vector2 # Size of the game window.
var target = position

func _ready():
	screen_size = get_viewport_rect().size

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

	# if velocity.x != 0:
	# 	$AnimatedSprite2D.animation = "walk"
	# 	$AnimatedSprite2D.flip_v = false
	# 	if velocity.x < 0:
	# 		$AnimatedSprite2D.flip_h = true
	# 	else:
	# 		$AnimatedSprite2D.flip_h = false
	# elif velocity.y != 0:
	# 	$AnimatedSprite2D.animation = "up"
	# 	if velocity.y > 0:
	# 		$AnimatedSprite2D.flip_v = true
	# 	else:
			$AnimatedSprite2D.flip_v = false
	
func focus_on_mouse():
	look_at(get_global_mouse_position())