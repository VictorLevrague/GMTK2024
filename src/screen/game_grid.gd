extends GridContainer

func _ready() -> void:
    Signals.drop.connect(check_all_body_constraints)
    print("checking")
    check_all_body_constraints(null)

func check_all_body_constraints(_slot: PanelContainer):
    var are_are_constraints_validated:= true
    for body_slot in get_children():
        if body_slot.get_child(0) != null: #ça part du principe que les slot sont initialisés à null. Le test if get_child_count() > 0 serait une sécurité en plus
            var body:= body_slot.get_child(0)
            if not body.body_data.check_constraints(body.body_data.constraint_array, self, body_slot.position / body_slot.size):
                print("failed constraint")
                are_are_constraints_validated = false
    var inventory_grid = get_parent().get_parent().get_node("InventoryGUI/InventoryGrid")
    if inventory_grid.get_child_count()> 0: #Pas ouf, mais disons que ça passe pour aujourd'hui
        var empty_inventory:= true
        for slot in inventory_grid.get_children():
            if slot.get_child_count() > 0:
                empty_inventory = false
        if empty_inventory and are_are_constraints_validated:
            print("All constraints validated !")
            Signals.emit_signal("all_constraints_validated")
    return are_are_constraints_validated
