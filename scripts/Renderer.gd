class_name MagicCircleRenderer extends Node2D

signal set_data(circle: MagicCircle)

signal set_inner_radius(value: int)
signal set_inner_double(value: bool)
signal set_inner_spacing(value: int)
signal set_inner_rings_number(value: int)
signal set_inner_rings_radius(value: int)
signal set_inner_rings_offset(value: float)

signal set_outer_radius(value: int)
signal set_outer_double(value: bool)
signal set_outer_spacing(value: int)
signal set_outer_rings_number(value: int)
signal set_outer_rings_radius(value: int)
signal set_outer_rings_offset(value: float)

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

	# Draw equidistant smaller circles on the main arc
	if arc.rings:
		var x: float
		var y: float
		for i in arc.rings:
			x = center.x + arc.radius * cos(arc.rings_offset_rad + arc.rings_distance_rad * i)
			y = center.y + arc.radius * sin(arc.rings_offset_rad + arc.rings_distance_rad * i)
			draw_arc(Vector2(x, y), arc.rings_radius, 0, 2*PI, 100, color, width, true)

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

func _on_set_inner_rings_number(value: int) -> void:
	if _circle:
		_circle.inner.rings = value
		_circle.inner.rings_distance_rad = 2*PI/_circle.inner.rings
		queue_redraw()

func _on_set_inner_rings_offset(value: float) -> void:
	if _circle:
		_circle.inner.rings_offset_rad = value
		queue_redraw()

func _on_set_inner_rings_radius(value: int) -> void:
	if _circle:
		_circle.inner.rings_radius = value
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

func _on_set_outer_rings_number(value: int) -> void:
	if _circle:
		_circle.outer.rings = value
		_circle.outer.rings_distance_rad = 2*PI/_circle.outer.rings
		queue_redraw()

func _on_set_outer_rings_offset(value: float) -> void:
	if _circle:
		_circle.outer.rings_offset_rad = value
		queue_redraw()

func _on_set_outer_rings_radius(value: int) -> void:
	if _circle:
		_circle.outer.rings_radius = value
		queue_redraw()
#endregion
