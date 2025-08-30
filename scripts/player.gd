extends CharacterBody2D
class_name Player


const SPEED = 300.0


var hold_delay := 0.5
var interact_time := 0.0


@onready var game: Game = get_owner()
@onready var inventory: Inventory = $Inventory


func _input(event):
	if event.is_action_pressed("interact"):
		if is_zero_approx(interact_time):
			interact_time = Time.get_unix_time_from_system()

	if event.is_action_released("interact"):
		if interact_time + hold_delay > Time.get_unix_time_from_system(): # not hold
			inventory.drop(global_position)
		else:
			pass
		interact_time = 0


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func on_collector_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		inventory.collect(body)
