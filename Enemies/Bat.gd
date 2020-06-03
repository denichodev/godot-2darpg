extends KinematicBody2D

export(PackedScene) var BatEffect;
var knockback = Vector2.ZERO;
onready var stats = $Stats;
onready var animatedSprite = $AnimatedSprite;
var knockbackVector = Vector2.ZERO;
var state = CHASE;
var velocity = Vector2.ZERO;
onready var playerDetectionArea = $PlayerDetectionArea;
export var FRICTION = 200;
export var ACCELERATION = 300;
export var MAX_SPEED = 50;
onready var alive = stats.health > 0;
onready var sprite = $AnimatedSprite;

enum {
	IDLE,
	WANDER,
	CHASE
}

func _physics_process(delta):
	if (!alive):
		velocity = Vector2.ZERO;
		return;
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta);
	knockback = move_and_slide(knockback);

	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
			seek_player();
		WANDER:
			pass;
		CHASE:
			sprite.flip_h = velocity.x < 0;
			var player = playerDetectionArea.player;
			if (player != null):
				var direction = (player.global_position - self.global_position).normalized();
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta);
			else:
				state = IDLE;

	velocity = move_and_slide(velocity)


func seek_player():
	if (playerDetectionArea.can_see_player()):
		state = CHASE;

func _on_Hurtbox_area_entered(area):
	knockbackVector = area.knockback_vector
	stats.set_health(stats.health - area.damage);

func onEffectAnimationFinished(finishedAnimation):
	match finishedAnimation:
		0:
			destroy();
		1:
			print("Shaked");

func destroy():
	queue_free();

func kill():
	animatedSprite.visible = false;
	var batEffect = BatEffect.instance();
	self.add_child(batEffect);
	batEffect.playAnimation();

func performKnockback():
	print("Vector", knockbackVector);
	knockback = knockbackVector * 120;

func _on_Stats_damaged(newHealth):
	if (newHealth <= 0):
		alive = false;
		kill();
	else:
		performKnockback();
	pass # Replace with function body.
