class_name Player
extends CharacterBody2D

@export var speed : float = 190.0
@export var jump_velocity : float = -215.0
@export var double_jump_velocity : float = -200
@export var RespawnPoint : CollisionObject2D
@export var health : int = 3

@onready var shoot_timer := $ShootAnimation as Timer
@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var gun = animated_sprite.get_node(^"Gun") as Gun
@onready var audio_player = $AudioStreamPlayer2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var debug_fly : bool = false
@export var more_jump : bool = false


func _physics_process(delta):
	if Input.is_action_pressed("debugfly"):
		debug_fly = true
	
	if not is_on_floor() && !debug_fly:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif more_jump:
			jump()
			more_jump = false

	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if debug_fly:
		velocity.y = direction.y * speed

	move_and_slide()
	update_facing_direction()
	
	
	var is_shooting := false
	if Input.is_action_just_pressed("shoot"):
		is_shooting = gun.shoot(animated_sprite.flip_h)

	var animation := get_new_animation(is_shooting)
	if animation != animated_sprite.animation and shoot_timer.is_stopped():
		if is_shooting:
			shoot_timer.start()
		animated_sprite.play(animation)
	
func get_new_animation(is_shooting := false) -> String:
	var animation_new: String
	if is_on_floor():
		if absf(velocity.x) > 0.1:
			
			animation_new = "run"
		else:
			animation_new = "idle"
	else:
		animation_new = "jumping"
	if(Input.get_vector("left", "right", "up", "down")) :
		audio_player.play()
	return animation_new
		
func dead():
	global_position = RespawnPoint.global_position;

func damaged():
	health -= 1
	if health <= 0:
		dead()

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = jump_velocity
	
#func double_jump():
	#velocity.y = double_jump_velocity
	#animated_sprite.play("jump_double")
	#animation_locked = true
	#has_double_jumped = true


		
