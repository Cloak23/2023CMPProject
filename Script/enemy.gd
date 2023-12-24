# scripted by Shin won young

class_name Enemy extends CharacterBody2D

# Enemy States. Walk, Stop, Dead
enum State {
	WALKING,
	STOP,
	DEAD,
}

@export var WALK_SPEED = 100.0

@export var running_max_time: float = 1.8
@export var stop_max_time: float = 1

var _state := State.WALKING
var running_time: float = 0.0
var stop_time: float = 0.0
var is_stop : bool = false
var direction: float = WALK_SPEED

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var anim_sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer

# for debugging
@onready var text_box := $TextEdit as TextEdit

func _ready():
	# Randomize Running Time
	running_max_time = randf_range(running_max_time-0.7, running_max_time+0.7)
	
func _physics_process(delta):
	
	# for debugging
	text_box.text = str(is_stop) + " : " + str(direction)
	
	# If enemy was dead, enemy can't move
	if _state == State.DEAD:
		pass
	
	# This is Running Habit Timer.
	# Running TIme -> Stop Time -> Running Time -> ....
	elif running_time >= running_max_time:
		_state = State.STOP
		stop_time += delta
		
		is_stop = true
		if stop_time >= stop_max_time:
			_state = State.WALKING
			
			stop_time = 0
			running_time = 0
	else:
		running_time += delta
		
		
	# Add Movement
	if _state == State.STOP:
		velocity.x = 0
	elif _state == State.WALKING and velocity.is_zero_approx():
		velocity.x = WALK_SPEED
		if is_stop:
			velocity.x = direction
			is_stop = false
		
	# Gravity
	velocity.y += gravity * delta
	
	# Turn the direction
	if not floor_detector_left.is_colliding():
		velocity.x = WALK_SPEED
	elif not floor_detector_right.is_colliding():
		velocity.x = -WALK_SPEED
	
	# When enemy stopped, restart running with this direction
	if velocity.x > 0:
		direction = WALK_SPEED
	elif velocity.x < 0:
		direction = -WALK_SPEED
		
	# Turn Sprite Direction
	if velocity.x > 0.0:
		anim_sprite.flip_h = true
	elif velocity.x < 0.0:
		anim_sprite.flip_h = false

	# Play now Animation
	var animation := get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)

	move_and_slide()

# Destroy the monster
func destroy():
	_state = State.DEAD
	velocity = Vector2.ZERO

# Animation Manager
func get_new_animation() -> StringName:
	var animation_new: StringName
	if _state == State.WALKING:
		animation_new = &"walk"
	elif _state == State.STOP:
		animation_new = &"idle"
	else:
		animation_new = &"destroy"
	return animation_new

# Attack to player
func _on_body_entered(body):
	if body is Player:
		(body as Player).damaged()
