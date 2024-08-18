extends Button

func _on_button_up() -> void:
	get_tree().root.get_child(1).get_node("ButtonClick").play()
	%OptionsMenu.hide()
