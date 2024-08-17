extends CanvasLayer

var game_grid_size = 9
var bodies_load = ["res://src/body/resources/test_purple_planet.tres",
                    "res://src/body/resources/test_red_planet.tres"]

func _ready() -> void:
    for i in game_grid_size:
        var grid_slot:= GridSlot.new()
        grid_slot.init(Vector2(128,128))
        %GameGrid.add_child(grid_slot)
    
    for i in bodies_load.size():
        var body_grid := GridBody.new()
        body_grid.init(load(bodies_load[i]))
        %GameGrid.get_child(i).add_child(body_grid)
