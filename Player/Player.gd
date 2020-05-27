extends KinematicBody2D

var velocity = Vector2.ZERO;

func _physics_process(delta):
	if (Input.is_action_pressed("ui_right")):
		position.x += 10;

