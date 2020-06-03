extends Node

export(int) var max_health = 1;
onready var health = max_health setget set_health;

signal damaged;

func set_health(newHealth):
	if (newHealth < health):
		emit_signal("damaged", newHealth);

	health = newHealth;
