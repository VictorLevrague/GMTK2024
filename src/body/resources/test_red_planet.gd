extends BodyData

#Test simple avec une contrainte de pas de planète à son voisinage

func check_constraints(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var has_planet_around: bool = false
    var neighbours:Array = findNeighbours(game_grid, coordinates)
    print()
    print("Neighbours: ", neighbours)
    for neighbour in neighbours:
        if neighbour.body_data.is_planet:
            has_planet_around = true
    return not has_planet_around

func findNeighbours(game_grid: GridContainer, coordinates: Vector2) ->Array:
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
#        print("calc dist from: ", coordinates, "to: ", grid_slot.position/grid_slot.size)
        var distance = coordinates.distance_to(grid_slot.position/grid_slot.size)
#        print("distance = ", distance)
        if distance <= sqrt(2) and distance > 0:
            if grid_slot.get_child_count() >0:
                neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp
