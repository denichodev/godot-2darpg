extends Area2D

export(PackedScene) var HitEffect;
export(bool) var withHitEffect = false;

func _on_Hurtbox_area_entered(area):
	if (withHitEffect):
		var hitEffect = HitEffect.instance();
		self.add_child(hitEffect, true);
		hitEffect.playWithCallback(funcref(self, "destroyChild"));

func destroyChild(child):
	child.queue_free();
