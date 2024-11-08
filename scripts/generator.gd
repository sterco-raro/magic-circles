class_name MagicCircleGenerator extends Node

static func generate() -> MagicCircle:

	var circle: MagicCircle = MagicCircle.new()

	circle.position = Vector2(0, 0)

	#region INNER CIRCLE
	circle.inner = MagicArc.new()
	circle.inner.radius = randi_range(Constants.INNER_CIRCLE_RADIUS_MIN, Constants.INNER_CIRCLE_RADIUS_MAX)
	circle.inner.double = true if randf() > 0.5 else false # TODO settings
	circle.inner.spacing = randi_range(3, 8)
	#endregion

	#region OUTER CIRCLE
	circle.outer = MagicArc.new()
	circle.outer.radius = randi_range(Constants.OUTER_CIRCLE_RADIUS_MIN, Constants.OUTER_CIRCLE_RADIUS_MAX)
	circle.outer.double = true if randf() > 0.5 else false
	circle.outer.spacing = randi_range(3, 8)
	#endregion

	return circle
