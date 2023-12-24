# scripted by Shin won young

class_name Player extends CharacterBody2D

@export var speed : float = 190.0
@export var jump_velocity : float = -215.0
@export var RespawnPoint : CollisionObject2D
@export var more_jump : bool = false

@onready var shoot_timer := $ShootAnimation as Timer
@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var attack = animated_sprite.get_node(^"Attack") as Attack
@onready var health_bar := $Health as Health
@onready var attack_shoot = $fire

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var debug_fly : bool = false
var is_moving: bool = false
var is_invincible = false
var health : int = 3

signal health_changed(value)

func _physics_process(delta):
	# for debugging
	if Input.is_action_pressed("debugfly"):
		debug_fly = true
	
	# in invincible state, character color changes to gray
	if is_invincible:
		animated_sprite.self_modulate = Color.DIM_GRAY
	else:
		animated_sprite.self_modulate = Color.WHITE
	
	if not is_on_floor() && !debug_fly:
		velocity.y += gravity * delta
	
	# do jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif more_jump:
			jump()
			more_jump = false

	# get keyboard input
	direction = Input.get_vector("left", "right", "up", "down")
	
	# add movement
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# for debugging
	if debug_fly:
		velocity.y = direction.y * speed

	move_and_slide()
	update_facing_direction()
	
	# do shooting
	var is_shooting := false
	if Input.is_action_just_pressed("shoot"):
		attack_shoot.play()
		is_shooting = attack.shoot(animated_sprite.flip_h)

	# update animation
	var animation := get_new_animation(is_shooting)
	if animation != animated_sprite.animation and shoot_timer.is_stopped():
		if is_shooting:
			shoot_timer.start()
		animated_sprite.play(animation)

# return current animation
func get_new_animation(is_shooting := false) -> String:
	var animation_new: String
	
	# shooting
	if is_shooting:
		animation_new = "attack"
		
	elif is_on_floor():
		# running
		if absf(velocity.x) > 0.1:
			is_moving = true
			animation_new = "run"
		# idle
		else:
			is_moving = false
			animation_new = "idle"
	# jump
	else:
		is_moving = false
		animation_new = "jumping"
		
		
	return animation_new

# respawn when player dead or go to next Level
func respawn():
	global_position = RespawnPoint.global_position;

# dead when touch the out of bound area or hp == 0
func dead():
	health = 3
	health_changed.emit(health)
	respawn()

# update animation direction
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

# jump
func jump():
	velocity.y = jump_velocity
	
## scripted by Dain Kim########
func damaged():
	if is_invincible:
		return
	
	health -= 1
	health_changed.emit(health)
	if health <= 0:
		dead()
	else:
		is_invincible = true
		invincibility_timer.start()
		
var invincibility_timer = Timer.new()
func _ready():
	invincibility_timer.wait_time = 2.5 
	invincibility_timer.one_shot = true
	add_child(invincibility_timer)
	invincibility_timer.timeout.connect(_on_invincibility_timer_timeout)
func _on_invincibility_timer_timeout():
	is_invincible = false

################################
