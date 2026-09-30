extends Area2D


@export var next_scene_path: String = "res://scenes/game2.tscn"

func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file(next_scene_path)
	print('进入下一关')
