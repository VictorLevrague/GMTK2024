extends Resource

class_name BodyData

@export var name: String
@export var fixed: bool = true
@export var x: int = 1
@export var y: int = 1
@export var size:= Vector2(x, y)
enum TILE_ID_LIST {BluePlanet, RedPlanet}
@export var tileID: TILE_ID_LIST

@export var texture: Texture

#func check_constraints():
#    pass
