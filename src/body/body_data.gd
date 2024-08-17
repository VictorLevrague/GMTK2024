extends Resource

class_name BodyData

@export var name: String
@export var fixed: bool = true
@export var is_planet: bool = false
@export var texture: Texture
@export var orientation_vector: Vector2

func check_constraints(game_grid: GridContainer, coordinates: Vector2):
    return true
