extends Button

@export var next_scene: PackedScene

func _on_button_up() -> void:
    #get_tree().root.get_child(1).get_node("ButtonClick").play()
    Signals.emit_signal("next_level_signal")
