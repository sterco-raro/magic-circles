class_name CircleUISection extends Control

#region SIGNALS
signal section_toggle_toggled(toggled_on: bool)
signal update_section_toggle(toggled_on: bool)
#endregion

#region ONREADY PROPS
#endregion

#region CUSTOM UPDATE FUNCTIONS
func update_section_visibility(visibility: bool):
	$SectionBody.visible = visibility
#endregion

#region SIGNALS HANDLERS
func _on_section_toggle_toggled(toggled_on: bool) -> void:
	section_toggle_toggled.emit(toggled_on)
	update_section_visibility(toggled_on)
func _on_update_section_toggle(toggled_on: bool) -> void:
	%SectionToggle.button_pressed = toggled_on
	update_section_visibility(toggled_on)
#endregion
