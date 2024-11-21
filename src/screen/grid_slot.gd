@tool

extends PanelContainer

class_name GridSlot

@export var body_data: BodyData = null:
    set(value):
        body_data = value
        %TextureBody.texture = value.texture if value != null else null

func _get_drag_data(at_position: Vector2):
    return self #slot
    
func _can_drop_data(at_position: Vector2, data: Variant) -> bool: #data = là où on on a drag
    return data.body_data != null
    
func _drop_data(at_position: Vector2, data: Variant) -> void: #data = là où on on a drag
    var previous_body_data = self.body_data
    self.body_data = data.body_data
    data.body_data = previous_body_data
    Tooltip.body_popup(Rect2i(Vector2i(global_position), Vector2i(size)), body_data)
    
func _on_mouse_entered():
    if body_data != null:
        Tooltip.body_popup(Rect2i(Vector2i(global_position), Vector2i(size)), body_data)

func _on_mouse_exited():
    Tooltip.hide_body_popup()
