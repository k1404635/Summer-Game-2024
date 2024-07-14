extends CharacterBody2D

@onready var all_interactions = []
@onready var holding_object = []

# var in_interaction = false
var interaction_timeout = 0
var frozen = false

# i think this is for camera movement, but i'll add it in for now
var scroll_left_limit = 0
var scroll_right_limit = 0
var scroll_up_limit = 0
var scroll_down_limit = 0
var scroll_velocity: Vector2 = Vector2(0, 0)

@export var speed_multiplier: float = 1

const SPEED = 300.0 * 60 # was originally just 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	#pdate_interactions()
	pass
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	# x-axis movement
	if not(frozen):
		if direction.x:
			velocity.x = direction.x * SPEED * delta
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if direction.y:
			velocity.y = direction.y * SPEED * delta
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	
		move_and_collide(velocity * delta * speed_multiplier)

		# Animation
		if direction.x > 0:
			$MeatPlayerSprite.play("MeatRight")
		if direction.x < 0:
			$MeatPlayerSprite.play("MeatLeft")
		if direction.y > 0:
			$MeatPlayerSprite.play("MeatFront")
		if direction.y < 0:
			$MeatPlayerSprite.play("MeatBack")
		
		if (direction == Vector2.ZERO) and ($MeatPlayerSprite.animation == "MeatFront"):
			$MeatPlayerSprite.animation = "MeatFrontStill"
		if (direction == Vector2.ZERO) and ($MeatPlayerSprite.animation == "MeatBack"):
			$MeatPlayerSprite.animation = "MeatBackStill"
		if (direction == Vector2.ZERO) and ($MeatPlayerSprite.animation == "MeatLeft"):
			$MeatPlayerSprite.animation = "MeatLeftStill"
		if (direction == Vector2.ZERO) and ($MeatPlayerSprite.animation == "MeatRight"):
			$MeatPlayerSprite.animation = "MeatRightStill"
		
func on_interaction_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()
	
func on_interaction_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	
func update_interactions():
	if all_interactions:
		$MeatCurrentInteraction.text = all_interactions[0].interact_label
	else:
		$MeatCurrentInteraction.text = ""
		
func execute_interactions():
	if len(all_interactions) > 0:
		$MeatCurrentInteraction.text = ""
		var cur_interaction = all_interactions[0]
		
		# if cur_interaction is a placeable location, then place it down on the counter
		
