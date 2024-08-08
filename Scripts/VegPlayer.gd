extends CharacterBody2D

@onready var holding_object = []
@onready var active = false

# var in_interaction = false
var interaction_timeout = 0
var frozen = false

@export var speed_multiplier: float = 1

const SPEED = 300.0 * 60 # was originally just 300.0

func _physics_process(delta):
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	# x-axis movement
	if not(frozen) and active:
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
			$VegPlayerSprite.play("VegRight")
		if direction.x < 0:
			$VegPlayerSprite.play("VegLeft")
		if direction.y > 0:
			$VegPlayerSprite.play("VegFront")
		if direction.y < 0:
			$VegPlayerSprite.play("VegBack")
		
		if (direction == Vector2.ZERO) and ($VegPlayerSprite.animation == "VegFront"):
			$VegPlayerSprite.animation = "VegFrontStill"
		if (direction == Vector2.ZERO) and ($VegPlayerSprite.animation == "VegBack"):
			$VegPlayerSprite.animation = "VegBackStill"
		if (direction == Vector2.ZERO) and ($VegPlayerSprite.animation == "VegLeft"):
			$VegPlayerSprite.animation = "VegLeftStill"
		if (direction == Vector2.ZERO) and ($VegPlayerSprite.animation == "VegRight"):
			$VegPlayerSprite.animation = "VegRightStill"
