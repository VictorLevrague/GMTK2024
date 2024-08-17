extends PanelContainer

class_name GridSlot

func init(size_slot: Vector2):
    custom_minimum_size = size_slot

func _ready() -> void:
    self.mouse_entered.connect(_on_mouse_entered)
    self.mouse_exited.connect(_on_mouse_exited)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
    if data is GridBody and get_child_count() == 0:
        return true
    if get_child_count() > 0:
        var body:= get_child(0)
        if body != data:
            self.theme_type_variation = "ForbiddenPanel"
        else:
            self.theme_type_variation = ""
    return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
    data.reparent(self) #Change le parent de data (body) au slot actuel
    if data.get_parent().get_parent().name == "InventoryGrid":
        if get_child_count() > 0:
            var body:= get_child(0)
            for constraint in body.body_data.constraint_array:
                constraint.is_validated = false
    Signals.emit_signal("drop", self)
    self.theme_type_variation = ""

func _notification(what: int) -> void:
  if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful():
    Signals.emit_signal("drop", self)

func _on_mouse_entered():
    Signals.emit_signal("mouse_in_slot", self)

func _on_mouse_exited():
    Signals.emit_signal("mouse_exited_slot", self)
