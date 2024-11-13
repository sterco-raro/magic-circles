class_name MagicCircleRenderer extends Node2D


#region SIGNALS
signal set_data(circle: MagicCircle)

signal set_inner_visibility(value: bool)
signal set_inner_line_color(value: Color)
signal set_inner_radius(value: int)
signal set_inner_double(value: bool)
signal set_inner_spacing(value: int)
signal set_inner_rings_visibility(value: bool)
signal set_inner_rings_number(value: int)
signal set_inner_rings_radius(value: int)
signal set_inner_rings_offset(value: float)

signal set_outer_visibility(value: bool)
signal set_outer_line_color(value: Color)
signal set_outer_radius(value: int)
signal set_outer_double(value: bool)
signal set_outer_spacing(value: int)
signal set_outer_rings_visibility(value: bool)
signal set_outer_rings_number(value: int)
signal set_outer_rings_radius(value: int)
signal set_outer_rings_offset(value: float)
#endregion


var _circle: MagicCircle
var _inner_circle_line_color: Color = Color.BEIGE
var _outer_circle_line_color: Color = Color.BEIGE


#region BUILTIN FUNCTIONS
func _draw() -> void:
	if _circle:
		if _circle.inner.enabled:
			draw_magic_arc(_circle.inner, _circle.position, _inner_circle_line_color, 2)
		if _circle.outer.enabled:
			draw_magic_arc(_circle.outer, _circle.position, _outer_circle_line_color, 2)
#endregion


#region CUSTOM FUNCTIONS
func draw_magic_arc(disk: MagicDisk, center: Vector2, color: Color, width: int) -> void:
	# Circles with smaller rings on it
	if disk.rings_enabled and disk.rings > 0:
		var ring_center: Vector2 = Vector2(
			center.x + disk.radius * cos(disk.rings_offset_rad),
			center.y + disk.radius * sin(disk.rings_offset_rad)
		)
		var ring_angle: float = abs(angle_between_tangents(center, ring_center, disk.radius, disk.rings_radius))

		# The main disk draw process starting and ending angles
		var end_angle_rad: float = 0
		var start_angle_rad: float = disk.rings_offset_rad + ring_angle/2

		for i in disk.rings:
			# Compute current ring center coordinates
			ring_center.x = center.x + disk.radius * cos(disk.rings_offset_rad + disk.rings_distance_rad * i)
			ring_center.y = center.y + disk.radius * sin(disk.rings_offset_rad + disk.rings_distance_rad * i)

			# Where to stop drawing the main disk for the current circular sector
			end_angle_rad = start_angle_rad + disk.rings_distance_rad - ring_angle

			# Draw circular sector
			if disk.double:
				draw_arc(center, disk.radius - disk.spacing, start_angle_rad, end_angle_rad, 200, color, width, true)
				draw_arc(center, disk.radius + disk.spacing, start_angle_rad, end_angle_rad, 200, color, width, true)
			else:
				draw_arc(center, disk.radius, start_angle_rad, end_angle_rad, 200, color, width, true)

			# Draw ring at the start of the current sector
			draw_arc(ring_center, disk.rings_radius, 0, 2*PI, 100, color, width, true)

			# Update starting point for the next iteration
			start_angle_rad = end_angle_rad + ring_angle

	# Simple circles
	else:
		if disk.double:
			draw_arc(center, disk.radius - disk.spacing, 0, 2*PI, 200, color, width, true)
			draw_arc(center, disk.radius + disk.spacing, 0, 2*PI, 200, color, width, true)
		else:
			draw_arc(center, disk.radius, 0, 2*PI, 200, color, width, true)

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

func angle_between_tangents(center1: Vector2, center2: Vector2, radius1: float, radius2: float):
	# Compute the angle between the two tangents to the second circle that connects to the center of the first one
	var results = circles_intersections(center1, center2, radius1, radius2)
	var p1: Vector2 = results[0]
	var p2: Vector2 = results[1]

	# The dot product is better than atan2 because it doesn't have edge cases (0 and 2PI)
	var length_product: float = p1.length() * p2.length()
	if length_product == 0:
		return acos(0)
	else:
		return acos( p1.dot(p2) / length_product )
#endregion


#region SIGNAL HANDLERS
func _on_set_data(circle: MagicCircle) -> void:
	_circle = circle
	queue_redraw()

func _on_set_inner_visibility(value: bool) -> void:
	_circle.inner.enabled = value
	queue_redraw()

func _on_set_inner_line_color(value: Color) -> void:
	_inner_circle_line_color = value
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

func _on_set_inner_rings_visibility(value: bool) -> void:
	_circle.inner.rings_enabled = value
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

func _on_set_outer_visibility(value: bool) -> void:
	_circle.outer.enabled = value
	queue_redraw()

func _on_set_outer_line_color(value: Color) -> void:
	_outer_circle_line_color = value
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

func _on_set_outer_rings_visibility(value: bool) -> void:
	_circle.outer.rings_enabled = value
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
