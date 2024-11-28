@tool

extends Panel

class_name GridSlot

@export var body_data: BodyData = null:
    set(value):
        body_data = value.duplicate() if value != null else null
        %TextureBody.texture = value.texture if value != null else null

@export var is_fixed: bool = false:
    set(value):
        is_fixed = value
        #%Lock.show() if value else %Lock.hide()
        %Lock.visible = value 

func _get_drag_data(at_position: Vector2):
    if self.body_data == null:
        return
    if self.is_fixed:
        return 
    return self #slot
    
func _can_drop_data(at_position: Vector2, data: Variant) -> bool: #data = là où on on a drag
    if self.is_fixed:
        return false
    return true
    
func _drop_data(at_position: Vector2, data: Variant) -> void: #data = là où on on a drag
    swap_bodies(self, data)
    Signals.emit_signal("drop")
    Tooltip.body_popup(Rect2i(Vector2i(global_position), Vector2i(size)), body_data)
    
func swap_bodies(drag_slot: GridSlot, drop_slot: GridSlot):
    var previous_body_data = drag_slot.body_data
    drag_slot.body_data = drop_slot.body_data
    drop_slot.body_data = previous_body_data
    
func _on_mouse_entered():
    if body_data != null:
        Tooltip.body_popup(Rect2i(Vector2i(global_position), Vector2i(size)), body_data)

func _on_mouse_exited():
    Tooltip.hide_body_popup()
