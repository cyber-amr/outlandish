extends SubViewport
class_name Inventory


@export var spawn := Vector2(40, 0)


var game: Game


@onready var items := $Items
@onready var player: Player = get_parent()


func _ready():
	await player.ready
	game = player.game


func collect(item: PhysicsBody2D):
	call_deferred("transfer", item, items, spawn)


func drop(pos: Vector2, item = null):
	pos -= Vector2(0, 96)
	if !item && items.get_child_count() > 0:
		item = items.get_child(-1)

	if item is RigidBody2D:
		call_deferred("transfer", item, game.rigids, pos)


func transfer(item: RigidBody2D, to, pos):
	item.reparent(to, false)
	item.owner = to
	item.global_position = pos
	item.linear_velocity = Vector2.ZERO


func on_body_exited(body: Node2D) -> void:
	drop(player.global_position, body)
