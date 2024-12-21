extends CanvasLayer

@export var main_menu: String= "res://src/screens/main_screen.tscn"

func _input(event):
    if event.is_action_pressed("echap"):
        self.visible = not self.visible


func _on_close_menu_button_up():
    AudioManager.get_node("ButtonClick").play()
    self.visible = not self.visible


func _on_reset_level_button_up():
    AudioManager.get_node("ButtonClick").play()
    get_tree().reload_current_scene()


func _on_back_to_menu_button_up():
    AudioManager.get_node("ButtonClick").play()
    get_tree().change_scene_to_file(main_menu) #change_scene_to_packed does not work because of cyclic references
