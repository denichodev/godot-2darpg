#Grass.gd
extends Node2D

export(PackedScene) var GrassEffect;
onready var sprite = $Sprite;

func _process(delta):
	if (Input.is_action_just_pressed("attack")):
		onAttacked();

func onAttacked():
	sprite.visible = false;
	var grassEffect = GrassEffect.instance();
	self.add_child(grassEffect)
	var destroy = funcref(self, "destroy");
	grassEffect.playDestroyed(destroy);

func destroy():
	queue_free();
