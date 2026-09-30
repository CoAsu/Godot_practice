extends CharacterBody2D


const SPEED =400.0
const JUMP_VELOCITY = -400.0
var max_health: int = 3
var current_health: int = 3
var is_dead: bool = false
var is_invincible: bool = false
var has_sword = false
var anim_sets: Dictionary[StringName, Dictionary] = {
&"base": {
&"idle": &"idle",
&"run": &"run",
&"jump": &"jumping",

},
&"sword": {
&"idle": &"with_sword_idle",
&"run": &"with_sword_jumping",
&"jump": &"with_sword_run",

}
}
var current_set: StringName = &"base"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_heart: HBoxContainer = $Player_heart


func _ready():
	equip_sword()
	$AnimatedSprite2D.play(anim_sets[current_set][&"idle"])

	
func equip_sword() -> void:
	if has_sword ==true:
		current_set = &"sword"

		
		
func _physics_process(delta: float) -> void:#跳跃动画细节没有完善，上升和下落时用的动画要不同
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	# Play animations:
	if is_on_floor():
		if direction == 0:
			animated_sprite.play(anim_sets[current_set][&"idle"])
		else:
			animated_sprite.play(anim_sets[current_set][&"run"])
	else:
		animated_sprite.play(anim_sets[current_set][&"jump"])
		
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is RigidBody2D:
			collider.apply_central_impulse(Vector2(direction * 50.0, 0))


func take_damage(damage):
	current_health-=damage
	player_heart.break_heart()
	if current_health<=0:
		is_dead=true	
		die()
	else:
		start_invincibility()
		
func die():#死亡动画以及世界重制
	is_dead = true
	print("You died!")
	Engine.time_scale = 0.5
	await get_tree().create_timer(0.5).timeout
	Engine.time_scale = 1.0
	Gamemanager.score = 0
	get_tree().reload_current_scene()
	
	
func start_invincibility():#扣血后的无敌时间
	is_invincible = true
	await get_tree().create_timer(1.0).timeout
	is_invincible = false
	



		
		
		
