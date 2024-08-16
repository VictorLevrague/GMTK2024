extends Resource

class_name Body

@export var fixed: bool = true
@export var x: int = 1
@export var y: int = 1
@export var size:= Vector2(x, y)
enum TILE_ID_LIST {BluePlanet, RedPlanet}
@export var tileID: TILE_ID_LIST

#func check_constraints():
#    pass

#Même si c'est étonnant, le constructeur suivant sera à effacer pour la suite.
#Je ne vais pas initialiser les body avec .new(), mais avec la création de fichier resource .tres,
#qui sont des sorttes d'instance de classes à manipuler dans l'éditeur et à qui on peut éditer du code perso
func _init(_tileID: int):
    tileID = _tileID
