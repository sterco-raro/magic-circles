class_name MagicCircleRenderer extends Node2D

signal set_data(circle: MagicCircle)

signal set_color(color: Color)

signal set_inner_draw_toggle(value: bool)
signal set_inner_radius(value: int)
signal set_inner_double(value: bool)
signal set_inner_spacing(value: int)
signal set_inner_rings_number(value: int)
signal set_inner_rings_radius(value: int)
signal set_inner_rings_offset(value: float)

signal set_outer_draw_toggle(value: bool)
signal set_outer_radius(value: int)
signal set_outer_double(value: bool)
signal set_outer_spacing(value: int)
signal set_outer_rings_number(value: int)
signal set_outer_rings_radius(value: int)
signal set_outer_rings_offset(value: float)

var _circle: MagicCircle

var _color: Color = Color.BEIGE

var _draw_inner_circle: bool = true
var _draw_outer_circle: bool = true

func _draw() -> void:
	if _circle:
		if _draw_inner_circle:
			draw_magic_arc(_circle.inner, _circle.position, _color, 2)
		if _draw_outer_circle:
			draw_magic_arc(_circle.outer, _circle.position, _color, 2)

func draw_magic_arc(arc: MagicArc, center: Vector2, color: Color, width: int) -> void:

	# Simple circles
	if not arc.rings:
		if arc.double:
			draw_arc(center, arc.radius - arc.spacing, 0, 2*PI, 200, color, width, true)
			draw_arc(center, arc.radius + arc.spacing, 0, 2*PI, 200, color, width, true)
		else:
			draw_arc(center, arc.radius, 0, 2*PI, 200, color, width, true)

	# Circles with smaller rings on it
	else:
		var ring_center: Vector2 = Vector2(
			center.x + arc.radius * cos(arc.rings_offset_rad),
			center.y + arc.radius * sin(arc.rings_offset_rad)
		)
		var ring_angle: float = abs(angle_between_tangents(center, ring_center, arc.radius, arc.rings_radius))

		# The main arc draw process starting and ending angles
		var end_angle_rad: float = 0
		var start_angle_rad: float = arc.rings_offset_rad + ring_angle/2

		for i in arc.rings:
			# Compute current ring center coordinates
			ring_center.x = center.x + arc.radius * cos(arc.rings_offset_rad + arc.rings_distance_rad * i)
			ring_center.y = center.y + arc.radius * sin(arc.rings_offset_rad + arc.rings_distance_rad * i)

			# Where to stop drawing the main arc for the current circular sector
			end_angle_rad = start_angle_rad + arc.rings_distance_rad - ring_angle

			# Draw circular sector
			if arc.double:
				draw_arc(center, arc.radius - arc.spacing, start_angle_rad, end_angle_rad, 200, color, width, true)
				draw_arc(center, arc.radius + arc.spacing, start_angle_rad, end_angle_rad, 200, color, width, true)
			else:
				draw_arc(center, arc.radius, start_angle_rad, end_angle_rad, 200, color, width, true)

			# Draw ring at the start of the current sector
			draw_arc(ring_center, arc.rings_radius, 0, 2*PI, 100, color, width, true)

			# Update starting point for the next iteration
			start_angle_rad = end_angle_rad + ring_angle

func circles_intersections(c0: Vector2, c1: Vector2, r0: float, r1: float):
	# TODO skip cases based on dist
	var centers_distance: float = c0.distance_to(c1)

	# Distance between c0 and the segment that connects the two intersections
	var a: float = (r0*r0 - r1*r1 + centers_distance*centers_distance) / (2 * centers_distance)

	# Half segment that connects the intersections
	var half_segment_p1_p2: float = sqrt(r0*r0 - a*a)

	# Intersection between the segment above and the centers_distance one
	var x3: float = c0.x + a * (c1.x - c0.x) / centers_distance
	var y3: float = c0.y + a * (c1.y - c0.y) / centers_distance

	# Intersections coordinates
	var xp1: float = x3 + half_segment_p1_p2 * (c1.y - c0.y) / centers_distance
	var xp2: float = x3 - half_segment_p1_p2 * (c1.y - c0.y) / centers_distance
	var yp1: float = y3 - half_segment_p1_p2 * (c1.x - c0.x) / centers_distance
	var yp2: float = y3 + half_segment_p1_p2 * (c1.x - c0.x) / centers_distance

	return [Vector2(xp1, yp1), Vector2(xp2, yp2)]

# Compute the angle between the two tangents to the second circle that connects to the center of the first one
func angle_between_tangents(center1: Vector2, center2: Vector2, radius1: float, radius2: float):
	var results = circles_intersections(center1, center2, radius1, radius2)
	var p1: Vector2 = results[0]
	var p2: Vector2 = results[1]

	# The dot product is better than atan2 because it doesn't have edge cases (0 and 2PI)
	var length_product: float = p1.length() * p2.length()
	if length_product == 0:
		return acos(0)
	else:
		return acos( p1.dot(p2) / length_product )

#region SIGNALS
func _on_set_data(circle: MagicCircle) -> void:
	_circle = circle
	queue_redraw()

func _on_set_color(color: Color):
	_color = color
	queue_redraw()

func _on_set_inner_draw_toggle(value: bool) -> void:
	_draw_inner_circle = value
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

func _on_set_outer_draw_toggle(value: bool) -> void:
	_draw_outer_circle = value
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
