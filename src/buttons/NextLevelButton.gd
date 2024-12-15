extends Button

func _on_button_up() -> void:
    get_tree().paused = false
    AudioManager.get_node("ButtonClick").play()
    Signals.emit_signal("next_level_signal")
