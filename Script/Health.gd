class_name Health extends CanvasLayer

# Assuming we have individual heart nodes as children of this node
# Here 'Heart1', 'Heart2', 'Heart3' are placeholders for the actual node names
@onready var player = get_parent()
@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
var hearts = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	if player != null:
		player.health_changed.connect(change_health)

# Called when health changes
func change_health(new_health):
	hearts = new_health
	update_hearts_visibility()

func update_hearts_visibility():
	heart1.modulate.a = 1 if hearts >= 1 else 0
	heart2.modulate.a = 1 if hearts >= 2 else 0
	heart3.modulate.a = 1 if hearts >= 3 else 0
