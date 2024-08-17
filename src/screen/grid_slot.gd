extends PanelContainer

class_name GridSlot

func init(size_slot: Vector2):
    custom_minimum_size = size_slot

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
    if data is GridBody and get_child_count() == 0:
        return true
    return false
#
#func _drop_data(at_position: Vector2, data: Variant) -> void:
##    if get_child_count() > 0:
##        var body:= get_child(0)
##        if body == data:
##            return
##        body.reparent(data.get_parent())
#    data.reparent(self) #Change le parent de data (body) au slot actuel
