extends Area2D
class_name Structure


func _init() -> void:
	collision_layer &= ~(1 << 0)
	collision_layer |= 1 << 2

	collision_mask &= ~(1 << 0)
	collision_mask |= 1 << 3

