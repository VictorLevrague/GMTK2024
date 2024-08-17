extends CanvasLayer

var game_grid_size = 6
var grid_columns = 2
var bodies_load = ["res://src/body/resources/test_purple_planet.tres",
                    "res://src/body/resources/test_red_planet.tres"]

func _ready() -> void:
    init_grid(%InventoryGrid)
    fill_grid(%InventoryGrid)

func init_grid(grid: GridContainer):
    grid.columns = grid_columns
    for i in game_grid_size:
        var grid_slot:= GridSlot.new()
        grid_slot.init(Vector2(128,128))
        grid.add_child(grid_slot)

func fill_grid(grid: GridContainer):
    for i in bodies_load.size():
        var body_grid := GridBody.new()
        body_grid.init(load(bodies_load[i]))
        grid.get_child(i).add_child(body_grid)
