extends Button

func _on_button_up() -> void:
    AudioManager.get_node("ButtonClick").play()
    Signals.emit_signal("next_level_signal")
