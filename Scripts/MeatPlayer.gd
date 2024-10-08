extends CharacterBody2D

@onready var holding_object = []
@onready var active = true

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
	
