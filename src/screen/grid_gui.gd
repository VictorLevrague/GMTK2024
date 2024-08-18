extends Node

#var bodies_load = ["res://src/body/resources/test_purple_planet.tres",
#                    "res://src/body/resources/test_red_planet.tres",
#                    "res://src/body/resources/test_ship_north.tres",
#                    "res://src/body/resources/test_ship_east.tres"]
var game_grid_bodies_load = ["res://src/body/resources/planets/telluric_planet.tres",
							"res://src/body/resources/sun.tres"]
var inventory_bodies_load = ["res://src/body/resources/planets/ring_planet.tres",
							"res://src/body/resources/planets/earth.tres",
							"res://src/body/resources/asteroid.tres",
							"res://src/body/resources/satellite.tres"]
@onready var grids: Array[GridContainer] = [get_node('InventoryGUI/InventoryGrid'), get_node('GameGridGUI/GameGrid')]
var grids_size:Array[int] = [6, 25]
var grids_columns:Array[int] = [2, 5]

func _ready() -> void:
	#get_tree().root.get_child(1).get_node("Music<NUMERO_DE_LA_MUSIQUE>").play()
	for i in grids.size():
		init_grid(grids[i], grids_size[i], grids_columns[i])
	fill_grid(grids[0], inventory_bodies_load)
	fill_grid(grids[1], game_grid_bodies_load)
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

func show_victory_screen():
	#get_tree().root.get_child(1).get_node("ValidationSuccess").play()
#    %WinningLevelScreen.show()
	pass
