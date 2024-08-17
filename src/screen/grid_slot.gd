extends PanelContainer

class_name GridSlot

#signal mouse_in_slot

func init(size_slot: Vector2):
    custom_minimum_size = size_slot

func _ready() -> void:
    self.mouse_entered.connect(_on_mouse_entered)
    self.mouse_exited.connect(_on_mouse_exited)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
    if data is GridBody and get_child_count() == 0:
        return true
    return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
#    if get_child_count() > 0:
#        var body:= get_child(0)
#        if body == data:
#            return
#        body.reparent(data.get_parent())
#    self.get_parent().dragging = false
    data.reparent(self) #Change le parent de data (body) au slot actuel
    Signals.emit_signal("drop")
    self.theme_type_variation = ""

func _on_mouse_entered():
    Signals.emit_signal("mouse_in_slot", self)

func _on_mouse_exited():
    Signals.emit_signal("mouse_exited_slot", self)
