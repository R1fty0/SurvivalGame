extends PanelContainer

@onready var property_container = %VBoxContainer


var frames_per_second

func _ready():
	# Link debug panel to game manager 
	GameManager.debug_panel = self
	# Hide debug panel on load
	visible = false
	

func _process(delta):
	# Prevent fps counter from updating when debug panel is hidden 
	if visible:
		frames_per_second = "%.2f" % (1.0/delta)

func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target: 
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)
		
func _input(event):
	# Toggle debug panel
	if event.is_action_pressed("toggle_debug"):
		visible =! visible
