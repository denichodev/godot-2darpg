#GrassEffect
extends AnimatedSprite

var onFinish;

func playDestroyed(_onDestroy):
	onFinish = _onDestroy;
	self.play("Destroyed");

func playShake(_onShake):
	onFinish = _onShake;
	self.play("Shake");

func _on_GrassEffect_animation_finished():
	onFinish.call_func();
