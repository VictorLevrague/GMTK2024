extends BodyData

#Test simple avec une contrainte de pas de planète à son voisinage

#var constraint_array: Array[Constraint] = []

var constraint1 = Constraint.new()
var constraint1_description := "No neighboring\n planets"

func _init():
    constraint1.init(false, constraint1_description, has_no_neighbour_planet)
    constraint_array = [constraint1]

func find_direct_neighbour(game_grid: GridContainer, coordinates: Vector2) ->Array:
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        var distance = coordinates.distance_to(grid_slot.position/grid_slot.size)
        if distance <= sqrt(2) + 0.5 and distance > 0:
            #LE + 0.5 est là pour la marge liées aux pb de normalization. Je pense que je peux l'enlever maintenant, je laisse juste en sécurité.
            if grid_slot.get_child_count() >0:
                if grid_slot.get_child(0).body_data.name != "Black Hole":
                    neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp

func has_no_neighbour_planet(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var has_planet_around: bool = false
    var neighbours:Array = find_direct_neighbour(game_grid, coordinates)
    for neighbour in neighbours:
        if neighbour.body_data.is_planet:
            has_planet_around = true
    return not has_planet_around
