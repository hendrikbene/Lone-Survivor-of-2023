extends CharacterBody2D

# Movement variables
@export var walk_speed : int  = 400
@export var dash_speed : int  = 1200
var is_dashing : bool = false
var is_moving : bool = false
var double_click_timer : Timer
var double_click_count := 0
var is_cooldown_active := false
var dash_timer : Timer
var dash_cooldown_timer : Timer

# Animation variables
var current_state := "idle_down"
var animated_sprite : AnimatedSprite2D

# new vars
var destination : Vector2 = Vector2(100, 100)

func _ready():
	animated_sprite = get_node("AnimatedSprite2D")
	dash_cooldown_timer = get_node("DashCooldownTimer")
	double_click_timer = get_node("DoubleClickTimer")
	dash_timer = get_node("DashTimer")
	dash_cooldown_timer.stop();

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("left_mouse_button"):
		destination = get_global_mouse_position()
		_process_double_click_dash_input()

func _physics_process(_delta):
	var movement
	if position.distance_to(destination) > 10:
		is_moving = true
		current_state = _get_animation_state()
		if is_dashing:
			movement = position.direction_to(destination) * dash_speed
		else:
			movement = position.direction_to(destination) * walk_speed
		velocity = movement
		move_and_slide()
	elif position.distance_to(destination) < 10 and is_moving:
		is_moving = false
		current_state = _get_animation_state()
		velocity = Vector2.ZERO

	print("is_moving => ", is_moving)
	print("State => ", current_state)
	animated_sprite.play(current_state)

func _process_double_click_dash_input():
	if not is_cooldown_active:
		if double_click_timer.is_stopped():
			double_click_timer.start()
		else:
			double_click_count += 1

		if double_click_count >= 2 and not is_dashing:
			double_click_timer.stop()
			dash_timer.start()
			dash_cooldown_timer.start()
			is_cooldown_active = true
			is_dashing = true
			double_click_count = 0

func _get_animation_state() -> String:
	var direction : String

	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			direction = "right"
			animated_sprite.flip_h = false
		else:
			direction = "left"
			animated_sprite.flip_h = true
	else:
		if velocity.y > 0:
			direction = "down"
		else:
			direction = "up"
			animated_sprite.flip_h = true
			
	return _get_animation_state_prefix() + "_" + direction

func _get_animation_state_prefix() -> String:
	return "walk" if is_moving else "idle"

func shoot():
	pass

func interact():
	if Input.is_action_just_pressed("interact"):
		pass


func _on_dash_cooldown_timer_timeout():
	is_cooldown_active = false

func _ondouble_click_timer_timeout():
	double_click_count = 0

func _on_dash_timer_timeout():	
	is_dashing = false
