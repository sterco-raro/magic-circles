class_name MagicCircleGenerator extends Node

static func generate() -> MagicCircle:

	var circle: MagicCircle = MagicCircle.new()

	circle.position = Vector2(0, 0)

	#region INNER CIRCLE
	circle.inner = MagicArc.new()
	circle.inner.radius = randi_range(Constants.INNER_CIRCLE_RADIUS_MIN, Constants.INNER_CIRCLE_RADIUS_MAX)
	circle.inner.double = true if randf() > 0.5 else false # TODO settings
	circle.inner.spacing = randi_range(3, 8)
	circle.inner.embedded = randi_range(0, 8)
	circle.inner.embedded_radius = randi_range(8, 16)
	if circle.inner.embedded:
		circle.inner.embedded_distance_rad = 2*PI/circle.inner.embedded
		circle.inner.embedded_offset_rad = randf_range(0, circle.inner.embedded_distance_rad)
	else:
		circle.inner.embedded_distance_rad = 0
		circle.inner.embedded_offset_rad = 0
	#endregion

	#region OUTER CIRCLE
	circle.outer = MagicArc.new()
	circle.outer.radius = randi_range(Constants.OUTER_CIRCLE_RADIUS_MIN, Constants.OUTER_CIRCLE_RADIUS_MAX)
	circle.outer.double = true if randf() > 0.5 else false
	circle.outer.spacing = randi_range(3, 8)
	circle.outer.embedded = randi_range(0, 8)
	circle.outer.embedded_radius = randi_range(8, 16)
	if circle.outer.embedded:
		circle.outer.embedded_distance_rad = 2*PI/circle.outer.embedded
		circle.outer.embedded_offset_rad = randf_range(0, circle.outer.embedded_distance_rad)
	else:
		circle.outer.embedded_distance_rad = 0
		circle.outer.embedded_offset_rad = 0
	#endregion

	return circle
