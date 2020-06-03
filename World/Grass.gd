extends Node2D

export(PackedScene) var GrassEffect;
onready var sprite = $Sprite;

func attacked():
	sprite.visible = false;
	var grassEffect = GrassEffect.instance();
	self.add_child(grassEffect)
	grassEffect.playAnimation();

func destroy():
	queue_free();

func onEffectAnimationFinished(finishedAnimation):
	match finishedAnimation:
		0:
			destroy();
		1:
			print("Shaked");

func _on_Hurtbox_area_entered(area):
	attacked();
