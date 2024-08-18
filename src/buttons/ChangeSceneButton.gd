extends Button

@export var next_scene: PackedScene

func _on_button_up() -> void:
	get_tree().root.get_child(1).get_node("ButtonClick").play()
	get_tree().change_scene_to_packed(next_scene)
