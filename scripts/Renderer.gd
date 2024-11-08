class_name MagicCircleRenderer extends Node2D

signal set_data(circle: MagicCircle)

signal set_inner_radius(value: int)
signal set_inner_double(value: bool)
signal set_inner_spacing(value: int)

signal set_outer_radius(value: int)
signal set_outer_double(value: bool)
signal set_outer_spacing(value: int)

var _circle: MagicCircle

var _color: Color = Color.BEIGE

func _draw() -> void:
	if _circle:
		draw_magic_arc(_circle.inner, _circle.position, _color, 2)
		draw_magic_arc(_circle.outer, _circle.position, _color, 2)

func draw_magic_arc(arc: MagicArc, center: Vector2, color: Color, width: int) -> void:
	if arc.double:
		draw_arc(center, arc.radius - arc.spacing, 0, 2*PI, 200, color, width, true)
		draw_arc(center, arc.radius + arc.spacing, 0, 2*PI, 200, color, width, true)
	else:
		draw_arc(center, arc.radius, 0, 2*PI, 200, color, width, true)

func set_color(color: Color):
	_color = color
	queue_redraw()

#region SIGNALS
func _on_set_data(circle: MagicCircle) -> void:
	_circle = circle
	queue_redraw()

func _on_set_inner_radius(value: int) -> void:
	if _circle:
		_circle.inner.radius = value
		queue_redraw()

func _on_set_inner_double(value: bool) -> void:
	if _circle:
		_circle.inner.double = value
		queue_redraw()

func _on_set_inner_spacing(value: int) -> void:
	if _circle:
		_circle.inner.spacing = value
		queue_redraw()

func _on_set_outer_radius(value: int) -> void:
	if _circle:
		_circle.outer.radius = value
		queue_redraw()

func _on_set_outer_double(value: bool) -> void:
	if _circle:
		_circle.outer.double = value
		queue_redraw()

func _on_set_outer_spacing(value: int) -> void:
	if _circle:
		_circle.outer.spacing = value
		queue_redraw()
#endregion
