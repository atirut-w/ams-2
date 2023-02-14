extends Control


@onready var file_menu := %File
@onready var help_menu := %Help

@onready var names := %VBoxContainer
@onready var times := %VBoxContainer2
@onready var types := %VBoxContainer4
@onready var lates := %VBoxContainer3


func _ready() -> void:
	file_menu.id_pressed.connect(_file_menu_id_pressed)
	help_menu.id_pressed.connect(_help_menu_id_pressed)


func _file_menu_id_pressed(id: int) -> void:
	match id:
		0:
			get_tree().quit()


func _help_menu_id_pressed(id: int) -> void:
	match id:
		0:
			var dialog := AcceptDialog.new()
			dialog.title = "About"
			dialog.dialog_text = "AMS 2: Attendant Management System, rewritten.\rMade by Atirut Wattanamongkol"
			
			add_child(dialog)
			dialog.popup_centered()
			await dialog.confirmed
			remove_child(dialog)


func _load_agl() -> void:
	var file := await ProgramManager.pick_file(["*.txt"])
	var data := AGLData.new()
	data.load_log(file)
	
	for i in 256:
		var event := data.events[i]
		var ename := Label.new()
		var etime := Label.new()
		var etype := Label.new()
		var elate := Label.new()
		
		ename.text = event.name
		etime.text = Time.get_time_string_from_unix_time(event.time)
		etype.text = event.EventType.find_key(event.type)
		
		elate.text = "Yes" if event.type == event.EventType.TimeIn && ProgramManager.is_late(event.time) else "No"
		
		names.add_child(ename)
		times.add_child(etime)
		types.add_child(etype)
		lates.add_child(elate)
