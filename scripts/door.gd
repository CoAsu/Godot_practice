extends Area2D

@export var next_scene_path: String = "res://scenes/game2.tscn"
@export var required_score: int = 10
@export var closed_door : Rect2=Rect2(1.0,9.0,14.0,22.0)
@export var opened_door : Rect2=Rect2(33.0,9.0,14.0,22.0)

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var is_open = false

func _ready() -> void:
	label.visible = false
	sprite.region_enabled = true
	update_door_state()

func _process(_delta: float) -> void:
	update_door_state()
	
func update_door_state():
	if Gamemanager.score < required_score:
		is_open = false
		sprite.region_rect = closed_door
		#将裁剪位置改到关闭的门的位置
	else:
		is_open =true	
		sprite.region_rect =opened_door



func _on_body_entered(body: Node2D) -> void:
	if is_open:
		get_tree().change_scene_to_file(next_scene_path)
	else:
		show_hint("Your scores are not enough to get into next area, still need " + str(required_score - Gamemanager.score) + " scores")
		
		
func show_hint(message: String) -> void:
	label.text = message
	label.visible = true
	timer.start()

func _on_timer_timeout() -> void:
	label.visible = false
