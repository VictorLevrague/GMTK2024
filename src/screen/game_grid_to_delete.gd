extends TileMap

var grid_x: int = 2
var grid_y: int = 3
var grid_dimension:= Vector2(grid_x, grid_y)
var game_grid = {}

#l'enum suivant n'est que pour le test. La version qui reste est dans body.gd
enum Tile {BluePlanet, RedPlanet}

func _ready() -> void:
    fill_game_grid_with_empty_values()
    test_manual_game_grid_filling_with_bodies()
    print_game_grid()

func _process(delta):
    erase_hovered_cells()
    hover_cells()

func fill_game_grid_with_empty_values():
    for x in grid_x:
        for y in grid_y:
            var coordinates:= Vector2(x, y)
            game_grid[coordinates] = null
#            set_cell(0, coordinates, 0, Vector2i(0, 0), 0) #layer, coords, source_id_tile, atlas_coord (do not change), alt_tile


#Fonction uniquement pour test
func test_manual_game_grid_filling_with_bodies():
    pass
    #Tile1 test
#    var new_body_class_test = Body.new(Tile.RedPlanet)
#    game_grid[Vector2(0,1)] = new_body_class_test
#    set_cell(0, Vector2(0,1), new_body_class_test.tileID, Vector2i(0, 0), 0)
##    #Tile2 test
#    var new_body_class_test2 = Body.new(Tile.BluePlanet)
#    game_grid[Vector2(1,2)] = new_body_class_test2
#    set_cell(0, Vector2(1,2), new_body_class_test2.tileID, Vector2i(0, 0), 0)

#Tile3 test. Ce test n'est pas compatible avec les 2 précédents: il faut enlever la fonction _init du fichier body.gd
#Cette méthode là sera celle utilisé pour après parce que je vais utiliser les ressources (.tres) pour chaque body, pour mettre leur Tile_id propre et leur fonction contrainte

#    var new_body_class_test3 = load("res://src/body/resources/test_red_planet.tres")
#    game_grid[Vector2(0,0)] = new_body_class_test3
#    set_cell(0, Vector2(0,0), new_body_class_test3.tileID, Vector2i(0, 0), 0)

func print_game_grid():
    for key in game_grid:
        var value = game_grid[key]
        print("key: ", key, "value: ", value)

func hover_cells():
    var tile = local_to_map(to_local(get_global_mouse_position()))
    if game_grid.has(Vector2(tile[0], tile[1])):
        set_cell(1, tile, 100, Vector2i(0, 0), 0)

func erase_hovered_cells():
    for x in grid_x:
        for y in grid_y:
            erase_cell(1, Vector2(x, y))
