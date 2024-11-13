class_name MagicArc extends RefCounted

# Main circle
var enabled: bool
var radius: float
var double: bool # Single or double arc
var spacing: int # Double arc spacing

# Rings embedded in the main arc
var rings: int
var rings_enabled: bool
var rings_radius: int
var rings_distance_rad: float # Circular sector angle between two points in radians (distance)
var rings_offset_rad: float # Circular sector offset in radians
