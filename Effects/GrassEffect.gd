#GrassEffect
extends AnimatedSprite

enum {
	DESTROY = 0,
	SHAKE = 1
}

func playDestroyed():
	connect("animation_finished", get_parent(), "onGrassEffectAnimationFinished", [DESTROY]);
	self.play("Destroyed");

func playShake():
	connect("animation_finished", get_parent(), "onGrassEffectAnimationFinished", [SHAKE]);
	self.play("Shake");
