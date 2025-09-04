extends Area2D
class_name Structure


const PROMPT_SLOT := preload("res://assets/UI-prompt_slot.svg")
const SLOT_REF := Vector2(0, -192)
const ROW_SEPARATION := Vector2(0, -24)


@export var upgrades: Array[PackedScene]
@export var upgrade_cost := 0

var sprites := Node.new()


func _init() -> void:
	collision_layer &= ~(1 << 0)
	collision_layer |= 1 << 2

	collision_mask &= ~(1 << 0)
	collision_mask |= 1 << 3


func _ready() -> void:
	add_child(sprites)
	connect("body_entered", on_body_entered)
	connect("body_exited", on_body_exited)


func on_body_entered(body: Node2D):
	if body is Player:
		prompt_payment()


func on_body_exited(body: Node2D):
	if body is Player:
		for i in range(sprites.get_child_count()):
			sprites.get_child(i).queue_free()


func prompt_payment() -> void:
	if !upgrades.size() || upgrade_cost <= 0:
		return

	for pos in get_positions():
		var sprite := Sprite2D.new()
		sprite.global_position = global_position + pos
		sprite.texture = PROMPT_SLOT
		sprites.add_child(sprite)


func get_positions() -> Array[Vector2]:
	var positions: Array[Vector2] = []
	var row_pos := SLOT_REF

	if upgrade_cost % 6 > 0:
		match upgrade_cost % 6:
			1:
				positions.append(row_pos)
			2:
				positions.append(row_pos.rotated(PI / 32))
				positions.append(row_pos.rotated(-PI / 32))
			3:
				positions.append(row_pos.rotated(PI / 32 * 2))
				positions.append(row_pos)
				positions.append(row_pos.rotated(-PI / 32 * 2))
			4:
				positions.append(row_pos.rotated(PI / 10))
				positions.append(row_pos.rotated(PI / 32))
				positions.append(row_pos.rotated(-PI / 32))
				positions.append(row_pos.rotated(-PI / 10))
			5:
				positions.append(row_pos.rotated(PI / 32 * 4))
				positions.append(row_pos.rotated(PI / 32 * 2))
				positions.append(row_pos)
				positions.append(row_pos.rotated(-PI / 32 * 2))
				positions.append(row_pos.rotated(-PI / 32 * 4))
		row_pos += ROW_SEPARATION

	@warning_ignore("integer_division")
	for r in range(upgrade_cost / 6):
		positions.append(row_pos.rotated(PI / 32 * 5))
		positions.append(row_pos.rotated(PI / 32 * 3))
		positions.append(row_pos.rotated(PI / 32))
		positions.append(row_pos.rotated(-PI / 32))
		positions.append(row_pos.rotated(-PI / 32 * 3))
		positions.append(row_pos.rotated(-PI / 32 * 5))
		row_pos += ROW_SEPARATION

	return positions
