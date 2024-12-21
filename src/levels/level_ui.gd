extends Control

func _on_open_menu_button_button_up():
    AudioManager.get_node("ButtonClick").play()
    %EchapMenu.visible = not %EchapMenu.visible
