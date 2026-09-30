extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_body_entered(body: Node2D) -> void:
	Gamemanager.red_coin_add_point()
	animation_player.play("pickup")
