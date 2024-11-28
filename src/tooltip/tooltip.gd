extends Control

func body_popup(slot_dimensions: Rect2i, body_data: BodyData):
    if body_data != null:
        write_body_popup_info(body_data)
        place_body_popup(slot_dimensions)
        %BodyPopup.size = Vector2i.ZERO #Reset size of container to miniaml size
        %BodyPopup.show()

func place_body_popup(slot_dimensions: Rect2i):
    var mouse_pos = get_viewport().get_mouse_position()
    var correction: Vector2i
    var padding = 10
    if mouse_pos.x <= get_viewport_rect().size.x/2:
        correction = Vector2i(slot_dimensions.size.x + padding, 0)
    else:
        correction = -Vector2i(%BodyPopup.size.x + padding, 0)
    %BodyPopup.position = slot_dimensions.position + correction

func write_body_popup_info(body_data: BodyData):
    %Name.text = body_data.name
    clean_constraint_constainer()
    for constraint in body_data.constraint_array:
        var constraint_display = load("res://src/Ui_items/constraint_display.tscn").instantiate()
        %ConstraintContainer.add_child(constraint_display)
        constraint_display.get_node("%Description").text = constraint.description
        constraint_display.get_node("%CheckBox").button_pressed = constraint.is_validated

func clean_constraint_constainer():
    for children in %ConstraintContainer.get_children():
        %ConstraintContainer.remove_child(children) #Avoid bug of delayed auto shrinking of containers
        children.queue_free()

func hide_body_popup():
    %BodyPopup.hide()
