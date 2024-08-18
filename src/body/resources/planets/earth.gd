extends BodyData

#Test simple avec une contrainte de pas de planète à son voisinage

#var constraint_array: Array[Constraint] = []

var constraint1 = Constraint.new()
var constraint1_description := "No neighboring\n planets"

var constraint2 = Constraint.new()
var constraint2_description := "Has sun at\n exactly 3 boxes"

var constraint3 = Constraint.new()
var constraint3_description := "No sun\nunder 2 boxes"

func _init():
    constraint1.init(false, constraint1_description, has_no_neighbour_planet)
    constraint2.init(false, constraint2_description, has_sun_at_3_boxes)
    constraint3.init(false, constraint3_description, has_no_sun_below_2_boxes)
    constraint_array = [constraint1, constraint2, constraint3]

func find_direct_neighbour(game_grid: GridContainer, coordinates: Vector2) ->Array:
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        var distance = coordinates.distance_to(grid_slot.position/grid_slot.size)
        if distance <= sqrt(2) + 0.5 and distance > 0:
            #LE + 0.5 est là pour la marge liées aux pb de normalization et erreurs numériques. Je laisse juste en sécurité.
            if grid_slot.get_child_count() >0:
                neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp

func has_no_neighbour_planet(game_grid: GridContainer, coordinates: Vector2) -> bool:
    #Code dupliqué d'un utre script (planet.gd) -> pas bien
    var has_planet_around: bool = false
    var neighbours:Array = find_direct_neighbour(game_grid, coordinates)

    for neighbour in neighbours:
        if neighbour.body_data.is_planet:
            has_planet_around = true
    return not has_planet_around

func find_body_with_distances(game_grid: GridContainer, coordinates: Vector2, in_between_distance: Vector2, distance_to: int) ->Array:
    """La Fonction permet à la fois de:
    - trouver les cases à une distance précise (en précisant distant_to à celle voulue, et en mettant les bornes minimales de distance associées)
    - trouver les cases en dessous d'une certaine distance (avec la borne min d'in_between_distance à 0)
    """
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        #C'est très très moche les conversions en entiers que j'ai mis. C'est un pansement pour la normalisation qui ne se fait pas bien selon les tailles de body, je ne sais pas encore pourquoi. ça passe peut-être avec ce pansement
        var x_to_compare = int(grid_slot.position[0]/grid_slot.size[0])
        var y_to_compare = int(grid_slot.position[1]/grid_slot.size[1])
        var distance = coordinates.distance_to(Vector2(x_to_compare, y_to_compare))
        if grid_slot.get_child_count() >0:
            print("name: ", grid_slot.get_child(0).body_data.name)
            print("distance: ", distance)
            print(distance>= in_between_distance[0])
            print(distance <= in_between_distance[1])
            print("x: ", abs(x_to_compare - coordinates[0]))
            print("y: ", abs(y_to_compare - coordinates[0]))
            print((distance != 0))
            print(distance>= in_between_distance[0])
            print(distance <= in_between_distance[1])
            print(abs(x_to_compare - coordinates[0]) <= distance_to)
            print(abs(x_to_compare - coordinates[0]))
            print(abs(y_to_compare - coordinates[1]) <= distance_to)
#            print("2: ", in_between_distance[1])
        if (distance != 0) and (distance>= in_between_distance[0]) and (distance <= in_between_distance[1]):
        #Suite mise à la ligne d'en dessous pour gagner de la place. Pourrait être mieux fait encore une fois
            if (abs(x_to_compare - coordinates[0]) <= distance_to + 0.4) and (abs(y_to_compare - coordinates[1]) <= distance_to + 0.4): #Encore une fois, maths un peu bancales liées aux pb de normalization je pense et p-e erreurs numériques
                if grid_slot.get_child_count() > 0:
                    neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp

func has_sun_at_3_boxes(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var is_sun_found: bool = false
    var neighbours:Array = find_body_with_distances(game_grid, coordinates, Vector2(sqrt(9) - 0.2, sqrt(27)), 3)
    print('has_sun_at_3_boxes neigh: ', neighbours)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sun":
            is_sun_found = true
    return is_sun_found

func has_no_sun_below_2_boxes(game_grid: GridContainer, coordinates: Vector2):
    var has_no_sun: bool = true
#    var neighbours:Array = find_body_with_distances(game_grid, coordinates, Vector2(0, sqrt(8)+0.05), 2)
#    for neighbour in neighbours:
#        if neighbour.body_data.name == "Sun":
#            has_no_sun = false
    return has_no_sun
