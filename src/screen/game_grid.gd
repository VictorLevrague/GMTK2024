extends TileMap

var grid_x: int = 4
var grid_y: int = 4
var grid_dimension:= Vector2(grid_x, grid_y)
var game_grid = {}

func _ready() -> void:
    fill_game_grid_with_empty_values()
    print_game_grid()

func _process(delta):
    erase_hovered_cells()
    hover_cells()

func fill_game_grid_with_empty_values():
    for x in grid_x:
        for y in grid_y:
            var coordinates:= Vector2(x, y)
            game_grid[str(coordinates)] = null # TODO: change in null body type
            set_cell(0, coordinates, 0, Vector2i(0, 0), 0) #layer, coords, source_id_tile, atlas_coord (do not change), alt_tile
#    game_grid[Vector2(0,0)] = Body.new()

func print_game_grid():
    for key in game_grid:
        var value = game_grid[key]
        print("key: ", key, "value: ", value)

func hover_cells():
    var tile = local_to_map(get_global_mouse_position())
    if game_grid.has(str(tile)):
        set_cell(1, tile, 3, Vector2i(0, 0), 0)

func erase_hovered_cells():
    for x in grid_x:
        for y in grid_y:
            erase_cell(1, Vector2(x, y))
