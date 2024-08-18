extends Node

var inventory_bodies_load = ["res://src/body/resources/planets/magnet_planet_right.tres",
                            "res://src/body/resources/planets/magnet_planet_left.tres",
                            "res://src/body/resources/planets/magnet_planet_left_2.tres",
                            "res://src/body/resources/planets/ring_planet.tres",
                            "res://src/body/resources/satellite.tres",
                            "res://src/body/resources/satellite2.tres",
                            "res://src/body/resources/dwarf_planet.tres"]
@onready var grids: Array[GridContainer] = [get_node('InventoryGUI/InventoryGrid'), get_node('GameGridGUI/GameGrid')]
var grids_size:Array[int] = [10, 25]
var grids_columns:Array[int] = [2, 5]

func _ready() -> void:
    get_tree().root.get_child(1).get_node("Music2").play()
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
    grid.get_child(2).add_child(body_grid1)
    ###
    var body_grid2 := GridBody.new()
    body_grid2.init(load("res://src/body/resources/fixed/comet_right_fixed.tres"))
    grid.get_child(5).add_child(body_grid2)
    ###
    var body_grid3 := GridBody.new()
    body_grid3.init(load("res://src/body/resources/fixed/black_hole_fixed.tres"))
    grid.get_child(11).add_child(body_grid3)
    ### Sister 1
    var body_grid4 := GridBody.new()
    body_grid4.init(load("res://src/body/resources/fixed/black_hole_fixed.tres"))
    grid.get_child(14).add_child(body_grid4)
    ###
    var body_grid5 := GridBody.new()
    body_grid5.init(load("res://src/body/resources/fixed/comet_left_fixed.tres"))
    grid.get_child(19).add_child(body_grid5)

func show_victory_screen():
    get_tree().root.get_child(1).get_node("ValidationSuccess").play()
    %WinningLevelScreen.show()
#    pass
