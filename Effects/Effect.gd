#GrassEffect
extends AnimatedSprite

enum {
	DESTROY = 0,
	SHAKE = 1,
	HIT = 2
}

func playAnimation():
	connect("animation_finished", get_parent(), "onEffectAnimationFinished", [DESTROY]);
	self.play("Animate");

func playWithCallback(onFinished):
	connect("animation_finished", self, "onAnimationFinished", [onFinished]);
	self.play("Animate");

func onAnimationFinished(onFinished):
	onFinished.call_func(self);
