extends PanelContainer

class_name GridSlot

func init(size_slot: Vector2):
    custom_minimum_size = size_slot

func _ready() -> void:
    self.mouse_entered.connect(_on_mouse_entered)
    self.mouse_exited.connect(_on_mouse_exited)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
#    if data is GridBody and get_child_count() == 0:
#        return true
#    if get_child_count() > 0:
#        var body:= get_child(0)
#        if body != data:
#            self.theme_type_variation = "ForbiddenPanel"
#        else:
#            self.theme_type_variation = ""
#    return false
    if get_child_count() > 0:
        if get_child(0).body_data.fixed: #TO DO: change color of panel in this case
            self.theme_type_variation = "ForbiddenPanel"
            return false
#        else:
#            self.theme_type_variation = ""
    return data is GridBody

func _drop_data(at_position: Vector2, data: Variant) -> void:
    swap_bodies(data)
    if data.get_parent().get_parent().name == "InventoryGrid":
        if get_child_count() > 0:
            var body:= get_child(0)
            for constraint in body.body_data.constraint_array:
                constraint.is_validated = false
    Signals.emit_signal("drop", self)
    self.theme_type_variation = ""

func swap_bodies(data: Variant):
    var slot_where_body_was_dragged = data.get_parent()
    if get_child_count() > 0:
        var body_at_drop_position = get_child(0)
        body_at_drop_position.reparent(slot_where_body_was_dragged)
        if body_at_drop_position.get_parent().get_parent().name == "InventoryGrid":
            for constraint in body_at_drop_position.body_data.constraint_array:
                constraint.is_validated = false
    data.reparent(self) #Change le parent de data (body) au slot actuel
    if data.get_parent().get_parent().name == "InventoryGrid":
        for constraint in data.body_data.constraint_array:
            constraint.is_validated = false

func remove_body_constraints_if_in_inventory(body: Variant):
    if body.get_parent().get_parent().name == "InventoryGrid":
        for constraint in body.body_data.constraint_array:
            constraint.is_validated = false
    

func _notification(what: int) -> void:
  if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful():
    Signals.emit_signal("drop", self)

func _on_mouse_entered():
    Signals.emit_signal("mouse_in_slot", self)

func _on_mouse_exited():
    Signals.emit_signal("mouse_exited_slot", self)
