class_name MagicCircleGenerator extends Node

static func generate() -> MagicCircle:

	var circle: MagicCircle = MagicCircle.new()

	circle.position = Vector2(0, 0)

	#region INNER CIRCLE
	circle.inner = MagicDisk.new()

	circle.inner.enabled = true if randf() > 0.15 else false

	circle.inner.radius = randi_range(Constants.INNER_CIRCLE_RADIUS_MIN, Constants.INNER_CIRCLE_RADIUS_MAX)

	circle.inner.line_color = Color(randf(), randf(), randf(), 1)
	circle.inner.double = true if randf() > 0.5 else false
	circle.inner.spacing = randi_range(Constants.INNER_CIRCLE_SPACING_MIN, Constants.INNER_CIRCLE_SPACING_MAX)

	circle.inner.rings = randi_range(Constants.INNER_CIRCLE_RINGS_MIN, Constants.INNER_CIRCLE_RINGS_MAX)
	circle.inner.rings_enabled = true if randf() > 0.5 else false
	circle.inner.rings_radius = randi_range(Constants.INNER_CIRCLE_RINGS_RADIUS_MIN, Constants.INNER_CIRCLE_RINGS_RADIUS_MAX)

	if circle.inner.rings:
		circle.inner.rings_distance_rad = 2*PI / circle.inner.rings
		circle.inner.rings_offset_rad = randf_range(0, circle.inner.rings_distance_rad)
	else:
		circle.inner.rings_distance_rad = 0
		circle.inner.rings_offset_rad = 0
	#endregion

	#region OUTER CIRCLE
	circle.outer = MagicDisk.new()

	circle.outer.enabled = true if randf() > 0.15 else false
	circle.outer.radius = randi_range(Constants.OUTER_CIRCLE_RADIUS_MIN, Constants.OUTER_CIRCLE_RADIUS_MAX)
	circle.outer.double = true if randf() > 0.5 else false
	circle.outer.spacing = randi_range(Constants.OUTER_CIRCLE_SPACING_MIN, Constants.OUTER_CIRCLE_SPACING_MAX)

	circle.outer.rings = randi_range(Constants.OUTER_CIRCLE_RINGS_MIN, Constants.OUTER_CIRCLE_RINGS_MAX)
	circle.outer.rings_enabled = true if randf() > 0.5 else false
	circle.outer.rings_radius = randi_range(Constants.OUTER_CIRCLE_RINGS_RADIUS_MIN, Constants.OUTER_CIRCLE_RINGS_RADIUS_MAX)

	if circle.outer.rings:
		circle.outer.rings_distance_rad = 2*PI / circle.outer.rings
		circle.outer.rings_offset_rad = randf_range(0, circle.outer.rings_distance_rad)
	else:
		circle.outer.rings_distance_rad = 0
		circle.outer.rings_offset_rad = 0
	#endregion

	# Avoid getting no circles at all
	if not circle.inner.enabled:
		circle.outer.enabled = true

	return circle
