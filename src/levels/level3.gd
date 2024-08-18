extends Node

var inventory_bodies_load = ["res://src/body/resources/planets/earth.tres",
                            "res://src/body/resources/satellite.tres",
                            "res://src/body/resources/satellite2.tres",
                            "res://src/body/resources/sun.tres",
                            "res://src/body/resources/mini_sun.tres",
                            "res://src/body/resources/mini_sun2.tres",
                            "res://src/body/resources/mini_sun3.tres",
                            "res://src/body/resources/mini_sun4.tres",
                            "res://src/body/resources/mini_sun5.tres"]
@onready var grids: Array[GridContainer] = [get_node('InventoryGUI/InventoryGrid'), get_node('GameGridGUI/GameGrid')]
var grids_size:Array[int] = [10, 25]
var grids_columns:Array[int] = [2, 5]

func _ready() -> void:
    for i in grids.size():
        init_grid(grids[i], grids_size[i], grids_columns[i])
    fill_grid(grids[0], inventory_bodies_load)
    fill_game_grid_manually(grids[1])
    #
    Signals.all_constraints_validated.connect(show_victory_screen)
    grids[1].check_all_body_constraints(null) #Check contrainte avant début du jeu

func init_grid(grid: GridContainer, grid_size: int, grid_columns: int):
    grid.columns = grid_columns
    for i in grid_size:
        var grid_slot:= GridSlot.new()
        grid_slot.init(Vector2(128,128))
        grid.add_child(grid_slot)

func fill_grid(grid: GridContainer, bodies: Array):
    for i in bodies.size():
        var body_grid := GridBody.new()
        body_grid.init(load(bodies[i]))
        grid.get_child(i).add_child(body_grid)

func fill_game_grid_manually(grid: GridContainer):
#Pas ouf, mais ça marchera pour aujourd'hui
    var body_grid1 := GridBody.new()
    body_grid1.init(load("res://src/body/resources/fixed/asteroid_fixed1.tres"))
    grid.get_child(1).add_child(body_grid1)
    ###
    var body_grid2 := GridBody.new()
    body_grid2.init(load("res://src/body/resources/fixed/earth_fixed.tres"))
    grid.get_child(5).add_child(body_grid2)
    ###
    var body_grid3 := GridBody.new()
    body_grid3.init(load("res://src/body/resources/fixed/asteroid_fixed2.tres"))
    grid.get_child(7).add_child(body_grid3)
    ###
    var body_grid4 := GridBody.new()
    body_grid4.init(load("res://src/body/resources/fixed/asteroid_fixed3.tres"))
    grid.get_child(13).add_child(body_grid4)
    ###
    var body_grid5 := GridBody.new()
    body_grid5.init(load("res://src/body/resources/fixed/asteroid_fixed4.tres"))
    grid.get_child(17).add_child(body_grid5)
    ###
    var body_grid6 := GridBody.new()
    body_grid6.init(load("res://src/body/resources/fixed/asteroid_fixed5.tres"))
    grid.get_child(19).add_child(body_grid6)

func show_victory_screen():
    %WinningLevelScreen.show()
#    pass
