extends Area2D
@onready var player: CharacterBody2D = $Player

@onready var timer: Timer = $Timer
@export var damage: int = 1

func _on_body_entered(body: Node2D) -> void:
	player.take_damage(damage)
	
