extends Control


@onready var names := %VBoxContainer
@onready var times := %VBoxContainer2
@onready var types := %VBoxContainer4
@onready var lates := %VBoxContainer3


func _load_agl() -> void:
	var file := await ProgramManager.open_file(["*.txt"])
	var data := AGLData.new()
	data.load_log(file)
	
	for event in data.events:
		var ename := Label.new()
		var etime := Label.new()
		var etype := Label.new()
		var elate := Label.new()
		
		ename.text = event.name
		etime.text = Time.get_time_string_from_unix_time(event.time)
		etype.text = event.EventType.find_key(event.type)
		
		var time_d := Time.get_time_dict_from_unix_time(event.time)
		if (time_d.hour > 7 || (time_d.hour == 7 && time_d.minute > 30)) && event.type == AGLData.Event.EventType.TimeIn:
			elate.text = "Yes"
		else:
			elate.text = "No"
		
		names.add_child(ename)
		times.add_child(etime)
		types.add_child(etype)
		lates.add_child(elate)
