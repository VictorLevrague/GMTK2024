extends Control

func body_popup(slot_dimensions: Rect2i, body_data: BodyData):
    if body_data != null:
        write_body_popup_info(body_data)
        %BodyPopup.size = Vector2i.ZERO #Reset size of container to minimal size. Set before the place_body_popup function to ensure right positionning correction
        place_body_popup(slot_dimensions)
        %BodyPopup.show()

func place_body_popup(slot_dimensions: Rect2i):
    var mouse_pos = get_viewport().get_mouse_position()
    var correction: Vector2i
    var padding = 10
    var x_correction:= 0
    var y_correction:= 0
    if mouse_pos.x <= get_viewport_rect().size.x/2:
        x_correction = slot_dimensions.size.x + padding
    else:
        x_correction = -(%BodyPopup.size.x + padding)
    if mouse_pos.y >= get_viewport_rect().size.y/2:
        y_correction = - (slot_dimensions.size.y + padding)
    else:
        y_correction = 0
    correction = Vector2i(x_correction, y_correction)
    %BodyPopup.position = slot_dimensions.position + correction

func write_body_popup_info(body_data: BodyData):
    %Name.text = body_data.name
    %Description.text = body_data.description
    %Description.visible = true if %Description.text != "" else false
    clean_constraint_constainer()
    for constraint in body_data.constraint_array:
        var constraint_display = load("res://src/tooltip/constraint_display.tscn").instantiate()
        %ConstraintContainer.add_child(constraint_display)
        constraint_display.get_node("%Description").text = constraint.description
        constraint_display.get_node("%CheckBox").button_pressed = constraint.is_validated

func clean_constraint_constainer():
    for children in %ConstraintContainer.get_children():
        %ConstraintContainer.remove_child(children) #Avoid bug of delayed auto shrinking of containers
        children.queue_free()

func hide_body_popup():
    %BodyPopup.hide()
