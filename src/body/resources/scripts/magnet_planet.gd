extends BodyData

#Test simple avec une contrainte de pas de planète à son voisinage

#var constraint_array: Array[Constraint] = []

var constraint1 = Constraint.new()
var constraint1_description := "No neighboring\n planets"

var constraint2 = Constraint.new()
var constraint2_description := "Body in front box"

func _init():
    constraint1.init(false, constraint1_description, has_no_neighbour_planet)
    constraint2.init(false, constraint2_description, has_body_in_front_box)
    constraint_array = [constraint1, constraint2]

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

func find_body_in_front_box(game_grid: GridContainer, coordinates: Vector2, direction: Vector2) ->Array:
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        if direction == Vector2(1,0):
            var x_to_compare = int(grid_slot.position[0]/grid_slot.custom_minimum_size[0])
            var y_to_compare = int(grid_slot.position[1]/grid_slot.custom_minimum_size[1])
            var x_comet = coordinates[0]
            var y_comet = coordinates[1]
            if int(y_comet) == int(y_to_compare): #pb de normalisation qui revient
                if int(x_to_compare) - int(x_comet) == 1:
                    if grid_slot.get_child_count() >0:
                        neighbours_temp.append(grid_slot.get_child(0))
        #Les directions suivantes sont non testées
        elif direction == Vector2(-1,0):
            var x_to_compare = int(grid_slot.position[0]/grid_slot.custom_minimum_size[0])
            var y_to_compare = int(grid_slot.position[1]/grid_slot.custom_minimum_size[1])
            var x_comet = coordinates[0]
            var y_comet = coordinates[1]
            if int(y_comet) == int(y_to_compare): #pb de normalisation qui revient
                if int(x_to_compare) - int(x_comet) == -1:
                    if grid_slot.get_child_count() >0:
                        neighbours_temp.append(grid_slot.get_child(0))
        elif direction == Vector2(0,1):
            var x_to_compare = int(grid_slot.position[0]/grid_slot.custom_minimum_size[0])
            var y_to_compare = int(grid_slot.position[1]/grid_slot.custom_minimum_size[1])
            var x_comet = coordinates[0]
            var y_comet = coordinates[1]
            if int(x_comet) == int(x_to_compare): #pb de normalisation qui revient
                if int(y_to_compare) - int(y_comet) == 1:
                    if grid_slot.get_child_count() >0:
                        neighbours_temp.append(grid_slot.get_child(0))
        elif direction == Vector2(0,-1):
            var x_to_compare = int(grid_slot.position[0]/grid_slot.custom_minimum_size[0])
            var y_to_compare = int(grid_slot.position[1]/grid_slot.custom_minimum_size[1])
            var x_comet = coordinates[0]
            var y_comet = coordinates[1]
            if int(x_comet) == int(x_to_compare): #pb de normalisation qui revient
                if int(y_to_compare) - int(y_comet) == -1:
                    if grid_slot.get_child_count() >0:
                        if grid_slot.get_child(0).body_data.name != "Black Hole":
                            neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp

func has_body_in_front_box(game_grid: GridContainer, coordinates: Vector2) -> bool:
#Pourrait être mieux 
    var has_body_in_front_box: bool = false
    var neighbours:Array = find_body_in_front_box(game_grid, coordinates, orientation_vector)
    if neighbours.size() > 0:
        has_body_in_front_box = true
    return has_body_in_front_box
