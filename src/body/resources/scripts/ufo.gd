extends BodyData

#Test simple avec une contrainte de pas de planète à son voisinage

#var constraint_array: Array[Constraint] = []

var constraint1 = Constraint.new()
var constraint1_description := "Has Earth at\n exactly 2 boxes"
var constraint2 = Constraint.new()
var constraint2_description := "Has no Sun-Mini Sun\n neighbor"
var constraint3 = Constraint.new()
var constraint3_description := "Has no UFO\n neighbor"
var constraint4 = Constraint.new()
var constraint4_description := "Has no Star Dust\n neighbor"

func _init():
    constraint1.init(false, constraint1_description, has_earth_at_2_boxes)
    constraint2.init(false, constraint2_description, has_no_sun_or_mini_sun_neighbor)
    constraint3.init(false, constraint3_description, has_no_ufo_neighbor)
    constraint4.init(false, constraint4_description, has_no_stardust_neighbor)
#    constraint_array = [constraint1, constraint2, constraint3, constraint4]
    constraint_array = [constraint1, constraint2, constraint3]

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

func has_no_sun_or_mini_sun_neighbor(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var has_sun_around: bool = false
    var neighbours:Array = find_direct_neighbour(game_grid, coordinates)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sun" or neighbour.body_data.name == "Mini Sun":
            has_sun_around = true
    return not has_sun_around

func has_no_ufo_neighbor(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var has_ufo_around: bool = false
    var neighbours:Array = find_direct_neighbour(game_grid, coordinates)
    for neighbour in neighbours:
        if neighbour.body_data.name == "UFO":
            has_ufo_around = true
    return not has_ufo_around

func has_no_stardust_neighbor(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var has_stardust_around: bool = false
    var neighbours:Array = find_direct_neighbour(game_grid, coordinates)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Star Dust":
            has_stardust_around = true
    return not has_stardust_around


func find_body_with_distances(game_grid: GridContainer, coordinates: Vector2, in_between_distance: Vector2, distance_max: float) ->Array:
    """La Fonction permet à la fois de:
    - trouver les cases à une distance précise (en précisant distant_to à celle voulue, et en mettant les bornes minimales de distance associées)
    - trouver les cases en dessous d'une certaine distance (avec la borne min d'in_between_distance à 0)
    """
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        var x_to_compare = int(grid_slot.position[0]/grid_slot.custom_minimum_size[0])
        var y_to_compare = int(grid_slot.position[1]/grid_slot.custom_minimum_size[1])
        var distance = coordinates.distance_to(Vector2(x_to_compare, y_to_compare))
        if (distance != 0) and (distance>= in_between_distance[0]) and (distance <= in_between_distance[1]):
            if (abs(x_to_compare - coordinates[0]) <= distance_max) and (abs(y_to_compare - coordinates[1]) <= distance_max):
                if grid_slot.get_child_count() > 0:
                    if grid_slot.get_child(0).body_data.name != "Black Hole":
                        neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp
    
func has_earth_at_2_boxes(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var is_earth_found: bool = false
    var neighbours:Array = find_body_with_distances(game_grid, coordinates, Vector2(sqrt(4) - 0.1, sqrt(8) + 0.1), 2 + 0.1)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Earth":
            is_earth_found = true
    return is_earth_found
