extends CharacterBody2D

@export var _Speed = 100.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Forward", "Back")
	if direction:
		velocity = direction * _Speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, _Speed)

	move_and_slide()
