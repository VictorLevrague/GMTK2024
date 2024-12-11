extends Button

func _on_button_up() -> void:
    AudioManager.get_node("ButtonClick").play()
    %OptionsMenu.show()
