extends HBoxContainer
@onready var heart_1: AnimatedSprite2D = $heart
@onready var heart_2: AnimatedSprite2D = $heart2
@onready var heart_3: AnimatedSprite2D = $heart3

@onready var hearts: Array[AnimatedSprite2D] = [$heart, $heart2, $heart3]

@export var player_path: NodePath

@onready var player: CharacterBody2D = $".."

func _ready() -> void:
	for i in hearts.size():
		hearts[i].play("full_health" )
	



func break_heart() -> void:
	if player.current_health >= 0:
		hearts[player.current_health].play("heart_attack")
		await hearts[player.current_health-1].animation_finished   # 等破碎动画播完
		hearts[player.current_health].play("empty_heart")
