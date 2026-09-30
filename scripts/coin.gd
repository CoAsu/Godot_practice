extends Area2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_body_entered(body: Node2D) -> void:
	Gamemanager.coin_add_point()
	animation_player.play("pickup")
