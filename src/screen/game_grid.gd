extends GridContainer

func _ready() -> void:
    Signals.drop.connect(check_all_body_constraints)

func check_all_body_constraints(_body_slot_dropped: PanelContainer):
    for body_slot in get_children(): #Children of GameGrid (a GridContainer) are body_slot (a PanelContainer)
        if body_slot.get_child(0) != null: #ça part du principe que les slot sont initialisés à null. Le test if get_child_count() > 0 serait une sécurité en plus
            var body:= body_slot.get_child(0)
            if not body.body_data.check_constraints(self, body_slot.position / body_slot.size):
                print("failed constraint of: ", body.body_data.name)
                return false
    print("All constraints validated !")
    return true
