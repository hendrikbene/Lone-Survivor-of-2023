extends CharacterBody2D

@export var speed = 400

var screen_size: Vector2 # Size of the game window.
var target = position
var animation_index = 0

func _ready():
	screen_size = get_viewport_rect().size

func _unhandled_input(event):

	if event.is_action_pressed("l_m_b"):
		target = get_global_mouse_position()
		
func _physics_process(_delta):
	#http://kidscancode.org/godot_recipes/3.x/2d/8_direction/
	velocity = position.direction_to(target).normalized() * speed
	# look_at(target)
	$AnimatedSprite2D.play()
	animation_index = snapped(velocity.angle(), PI/4) / (PI/4)
	animation_index = wrapi(int(animation_index), 0, 8)

	if position.distance_to(target) > 10:
		move_and_slide()
		if animation_index == 2 || animation_index == 6:
			if animation_index == 2:
				$AnimatedSprite2D.animation = "walk_down"
			elif animation_index == 6:
				$AnimatedSprite2D.animation = "walk_up"
		elif animation_index == 3 || animation_index == 4 || animation_index == 5:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = true
		elif animation_index == 0 ||animation_index == 1 || animation_index == 7:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.stop()


	
	# 8-DIRECTIONAL MOVEMENT/ANIMATION    current_animation = "idle"



	# if Input.is_action_pressed("l_m_b") and mouse.length() > 10:
	# 	var current_animation: = "walk"
	# 	move_and_slide()
	# 	$AnimatedSprite2D.animation = current_animation + str(a)


	# if velocity.x > 0 and velocity.y > 0:
	# 	$AnimatedSprite2D.play("walk_down")
	# elif velocity.x > 0 and velocity.y < 0:
	# 	$AnimatedSprite2D.play("walk")
	# 	$AnimatedSprite2D.flip_h = false
	# elif velocity.x < 0 and velocity.y < 0:
	# 	$AnimatedSprite2D.play("walk_up")
	# elif velocity.x < 0 and velocity.y > 0:
	# 	$AnimatedSprite2D.play("walk")
	# 	$AnimatedSprite2D.flip_h = true
	# animatie player using mouse direction dividing the screen in 4 sectors of

	
# func _process(_delta):
# 	pass


# # func _process(_delta): # every frame 
# # 	focus_on_mouse()
