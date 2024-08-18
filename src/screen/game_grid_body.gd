extends TextureRect

class_name GridBody

var body_data: BodyData
var dragging: bool = false
@onready var tool_tip = preload("res://src/Ui_items/tool_tip.tscn")
@onready var tool_tip_title_only = preload("res://src/Ui_items/tool_tip_title_only.tscn")

func init(_data: BodyData) -> void:
    body_data = _data

func _ready() -> void:
    expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    texture = body_data.texture
    
    Signals.mouse_in_slot.connect(mouse_entered_slot)
    Signals.mouse_exited_slot.connect(mouse_exited_slot)
    Signals.drop.connect(body_dropped)
    self.mouse_entered.connect(mouse_entered_body_grid)
    self.mouse_exited.connect(mouse_exited_body_grid)

func mouse_entered_body_grid():
    display_tooltip()

func display_tooltip():
#	print("view size: ", get_viewport().get_visible_rect().size)
#	print("local mouse posi: ", get_local_mouse_position())
#	print("global mouse posi: ", get_global_mouse_position())
    var x_mouse = get_global_mouse_position()[0]
    var y_mouse = get_global_mouse_position()[1]
    var x_window = get_viewport().get_visible_rect().size[0]
    var y_window = get_viewport().get_visible_rect().size[1]
    var offset: Vector2
    if body_data.constraint_array.size() > 0:
        var tool_tip_instance = tool_tip.instantiate()
        tool_tip_instance.size = Vector2(150,125)
        if (x_mouse > x_window / 2) and (y_mouse > y_window / 2):
            print("bottom right")
            offset = - 1.05 * tool_tip_instance.size
            tool_tip_instance.position = 2* offset
        elif (x_mouse < x_window / 2) and (y_mouse < y_window / 2):
            print("upper left")
            offset = 1.2 * tool_tip_instance.size
            tool_tip_instance.position = offset
        elif (x_mouse > x_window / 2) and (y_mouse < y_window / 2):
            print("upper right")
            var offset_x = - 2* tool_tip_instance.size[0]
            var offset_y = 1.2*tool_tip_instance.size[1]
            offset = Vector2(offset_x, offset_y)
            tool_tip_instance.position = offset
        elif (x_mouse < x_window / 2) and (y_mouse > y_window / 2):
            print("bottom left")
            var offset_x = 1.2* tool_tip_instance.size[1] 
            var offset_y = - 2* tool_tip_instance.size[0]
            offset = Vector2(offset_x, offset_y)
            tool_tip_instance.position = offset
#		else:
            #tool_tip_instance.position = get_local_mouse_position()
        get_tooltip_info(tool_tip_instance)
        self.add_child(tool_tip_instance)
    else:
        var tool_tip_title_instance = tool_tip_title_only.instantiate()
        tool_tip_title_instance.size = Vector2(10,10)
        #
        if (x_mouse > x_window / 2) and (y_mouse > y_window / 2):
            print("bottom right")
            offset = - 1.05 * tool_tip_title_instance.size
            tool_tip_title_instance.position = 2* offset
        elif (x_mouse < x_window / 2) and (y_mouse < y_window / 2):
            print("upper left")
            offset = 1.05 * tool_tip_title_instance.size
            tool_tip_title_instance.position = offset
        elif (x_mouse > x_window / 2) and (y_mouse < y_window / 2):
            print("upper right")
            var offset_x = - 2* tool_tip_title_instance.size[0]
            var offset_y = 1.2*tool_tip_title_instance.size[1]
            offset = Vector2(offset_x, offset_y)
            tool_tip_title_instance.position = offset
        elif (x_mouse < x_window / 2) and (y_mouse > y_window / 2):
            print("bottom left")
            var offset_x = 1.2* tool_tip_title_instance.size[1] 
            var offset_y = - 2* tool_tip_title_instance.size[0]
            offset = Vector2(offset_x, offset_y)
            tool_tip_title_instance.position = offset
        #
        print("name: ", body_data.name)
        if body_data.name == "Black Hole":
            tool_tip_title_instance.get_node("%Title").text = body_data.name + "\n (This is not a body)"
        else:
            tool_tip_title_instance.get_node("%Title").text = body_data.name
        self.add_child(tool_tip_title_instance)

func get_tooltip_info(tool_tip_instance):
    if body_data.name == "Dwarf Planet":
        tool_tip_instance.get_node("%Title").text = body_data.name + "\n (This is not a planet)"
    else:
        tool_tip_instance.get_node("%Title").text = body_data.name
    var constraint_container = tool_tip_instance.get_node("%ConstraintContainer")
    for constraint in body_data.constraint_array:
        var constraint_display = load("res://src/Ui_items/constraint_hbox.tscn").instantiate()
        constraint_container.add_child(constraint_display)
        constraint_display.get_node("%Description").text = constraint.description
        constraint_display.get_node("%CheckBox").button_pressed = constraint.is_validated

func mouse_exited_body_grid():
    var tooltip_to_remove = get_node("ToolTip")
    var tooltip_title_to_remove = get_node("ToolTipTitleOnly")
#	self.remove_child(node_to_remove) 
    if tooltip_to_remove:
        tooltip_to_remove.hide()
        tooltip_to_remove.queue_free() #Attention: bug si on fait cette commande et qu'il y a 2 instances de ressources (.tres) identiques en jeu
    if tooltip_title_to_remove:
        tooltip_title_to_remove.hide()
        tooltip_title_to_remove.queue_free() #Attention: bug si on fait cette commande et qu'il y a 2 instances de ressources (.tres) identiques en jeu


func mouse_entered_slot(body_slot: PanelContainer):
    if dragging:
        body_slot.theme_type_variation = "HighlightedPanel"


func mouse_exited_slot(panelC: PanelContainer):
    panelC.theme_type_variation = ""

func body_dropped(panelC: PanelContainer):
    get_tree().root.get_child(1).get_node("BodyMovement").play()
    dragging = false
    panelC.theme_type_variation = ""

func _get_drag_data(at_position: Vector2):
    if not body_data.fixed:
        dragging = true
        set_drag_preview(make_drag_preview(at_position))
        return self

func make_drag_preview(at_position: Vector2):
    var drag_texture:= TextureRect.new()
    drag_texture.texture = texture
    drag_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    drag_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    drag_texture.custom_minimum_size = size
    drag_texture.modulate.a = 0.5 #Transparency
    drag_texture.position = Vector2(-at_position)

    var drag_control_node := Control.new()
    drag_control_node.add_child(drag_texture)
    return drag_control_node
